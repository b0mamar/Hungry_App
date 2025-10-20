import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
  });
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: TextScaler.linear(1),
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }
}
