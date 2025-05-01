import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';

class VerticalSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const VerticalSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final double sliderWidth = 50;
  final double sliderHeight = 150;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: SizedBox(
        width: sliderHeight,
        height: sliderWidth,
        child: VerticalSliderPainter(
          trackHeight: sliderWidth,
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class VerticalSliderPainter extends StatefulWidget {
  final double trackHeight;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const VerticalSliderPainter({
    super.key,
    required this.trackHeight,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  State<VerticalSliderPainter> createState() => _VerticalSliderPainterState();
}

class _VerticalSliderPainterState extends State<VerticalSliderPainter> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: widget.trackHeight,
        overlayShape: SliderComponentShape.noOverlay,
        thumbShape: SliderComponentShape.noThumb,
        trackShape: CustomSliderTrackShape(),
      ),
      child: Slider(
        value: widget.value,
        min: widget.min,
        max: widget.max,
        onChanged: widget.onChanged,
        inactiveColor: Colors.transparent,
      ),
    );
  }
}

class CustomSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    ui.Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required ui.TextDirection textDirection,
    required ui.Offset thumbCenter,
    ui.Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    double additionalActiveTrackHeight = 0,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final trackHeight = sliderTheme.trackHeight!;
    final ColorTween activeTrackColorTween =
        ColorTween(begin: sliderTheme.disabledActiveTrackColor, end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween =
        ColorTween(begin: sliderTheme.disabledInactiveTrackColor, end: sliderTheme.inactiveTrackColor);

    final Paint activePaint = Paint()..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()..color = inactiveTrackColorTween.evaluate(enableAnimation)!;

    final Paint leftTrackPaint = textDirection == TextDirection.ltr ? activePaint : inactivePaint;
    final Paint rightTrackPaint = textDirection == TextDirection.ltr ? inactivePaint : activePaint;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    activePaint.shader = ui.Gradient.linear(
      ui.Offset(trackRect.left, 0),
      ui.Offset(thumbCenter.dx, 0),
      [BrandColors.colorPrimaryDark, BrandColors.colorAccent],
    );

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    Radius.circular(trackRect.height / 2);

    final Paint shadow = Paint()..color = const Color(0xffdadada);
    context.canvas.clipRRect(
      RRect.fromLTRBR(trackRect.left, trackRect.top, trackRect.right, trackRect.bottom, trackRadius),
    );
    context.canvas
        .drawRRect(RRect.fromLTRBR(trackRect.left, trackRect.top, trackRect.right, trackRect.bottom, trackRadius), shadow);

    shadow..maskFilter = MaskFilter.blur(BlurStyle.normal, ui.Shadow.convertRadiusToSigma(10));
    context.canvas.drawRRect(
        RRect.fromLTRBR(trackRect.left - trackHeight, trackRect.top + trackHeight / 2, trackRect.right,
            trackRect.bottom + trackHeight / 2, trackRadius),
        shadow);

    context.canvas.drawRRect(
      RRect.fromLTRBR(trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom, Radius.circular(15)),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBR(thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom, trackRadius),
      rightTrackPaint,
    );
  }
}
