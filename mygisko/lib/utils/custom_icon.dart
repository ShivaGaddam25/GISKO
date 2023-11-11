import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final String iconPath;
  final Color color;

  const CustomIcon({
    required this.iconPath,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      color: color,
      width: 24, // Adjust the size as per your requirement
      height: 24,
    );
  }
}
