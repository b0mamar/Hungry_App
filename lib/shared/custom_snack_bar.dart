import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

SnackBar customSnackBar(dynamic error) {
  return SnackBar(
    padding: EdgeInsets.all(10),
    content: Row(
      children: [
        Icon(Icons.info, color: Colors.white),
        Gap(20),
        Text(error, overflow: TextOverflow.clip),
      ],
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.none,
  );
}
