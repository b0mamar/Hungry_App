import 'package:flutter/material.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  CustomAuthButton({super.key, this.ontap, required this.text});
  final Function()? ontap;
  final String text;
  final Color buttonColor = AppColors.primaryColor;
  final Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 55,
        child: Center(
          child: CustomText(
            text: text,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            size: 15,
          ),
        ),
      ),
    );
  }
}
