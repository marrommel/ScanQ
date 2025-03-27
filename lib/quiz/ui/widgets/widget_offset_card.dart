import 'package:flutter/material.dart';

class OffsetCard extends StatefulWidget {
  final String heading;
  final List<Widget> children;

  /// optional parameters
  final double topOffset;
  final double borderRadius;
  final double headingFontSize;
  final Color headingColor;
  final Color backgroundColor;
  final EdgeInsets padding;

  const OffsetCard({
    Key? key,
    required this.heading,
    required this.children,
    this.topOffset = 70,
    this.borderRadius = 40,
    this.headingFontSize = 22,
    this.headingColor = Colors.white,
    this.backgroundColor = const Color(0xFAFAFAFF),
    this.padding = const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
  }) : super(key: key);

  @override
  _OffsetCardState createState() => _OffsetCardState();
}

class _OffsetCardState extends State<OffsetCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: widget.topOffset),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              widget.heading,
              style: TextStyle(
                color: widget.headingColor,
                fontSize: widget.headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(widget.borderRadius)),
            ),
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                  stops: [0, 0.05, 1, 1], // 10% purple, 80% transparent, 10% purple
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: SingleChildScrollView(
                padding: widget.padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.children,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
