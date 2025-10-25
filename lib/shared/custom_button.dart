import 'package:flutter/material.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    required this.height,
    required this.width,
    this.color,
    this.radius,
  });
  final String text;
  final Function()? onTap;
  final double height;
  final double width;
  final Color? color;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius ?? 13),
        ),
        child: Center(
          child: CustomText(text: text, color: Colors.white),
        ),
      ),
    );
  }
}
