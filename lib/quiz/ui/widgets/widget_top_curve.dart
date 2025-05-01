import 'package:flutter/cupertino.dart';

import '../../../common/data/brand_colors.dart';

class TopCurve extends StatelessWidget {
  const TopCurve({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 1),
      child: ClipPath(
        clipper: CurveClipper(),
        child: Container(
          height: 80,
          color: BrandColors.colorPrimary,
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 100,
        size.width,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
