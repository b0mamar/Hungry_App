import 'package:flutter/material.dart';

class CustomProfileTextfield extends StatelessWidget {
  const CustomProfileTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isPassword,
  });
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        cursorColor: Colors.white,
        cursorHeight: 20,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
