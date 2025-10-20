import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.bergerName,
    required this.bergerDesc,
    required this.rating,
  });

  final String image, bergerName, bergerDesc, rating;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(5),
            Center(child: Image.asset(image, width: 120, height: 120)),
            CustomText(text: bergerName, fontWeight: FontWeight.bold),
            CustomText(text: bergerDesc),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                CustomText(text: rating),
                Spacer(),
                Icon(CupertinoIcons.heart_circle_fill, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
