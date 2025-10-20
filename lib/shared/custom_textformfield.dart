import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextformfield extends StatefulWidget {
  const CustomTextformfield({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
  });
  final TextEditingController controller;
  final String hint;
  final bool isPassword;

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill in your ${widget.hint}';
        }
        return '';
      },
      controller: widget.controller,
      obscureText: _obscureText,
      cursorHeight: 20,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggelPassword,
                child: Icon(CupertinoIcons.eye_solid),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hint,
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  void _toggelPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
