import 'package:flutter/material.dart';
import 'package:hangry_app/shared/custom_text.dart';

class OrderSummaryTextWidget extends StatelessWidget {
  const OrderSummaryTextWidget({
    super.key,
    required this.orderAmount,
    required this.price,
    required this.isbold,
    required this.isSmall,
    this.isItPrice,
  });
  final String orderAmount;
  final String price;
  final bool isbold;
  final bool isSmall;
  final bool? isItPrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: orderAmount,
          size: isSmall ? 13 : 18,
          color: isbold ? Colors.black : Colors.grey.shade500,
          fontWeight: isbold ? FontWeight.w600 : FontWeight.normal,
        ),
        CustomText(
          text: '\$ $price',
          size: isSmall ? 13 : 18,
          color: isbold ? Colors.black : Colors.grey.shade500,
          fontWeight: isbold ? FontWeight.w600 : FontWeight.normal,
        ),
      ],
    );
  }
}
