import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/features/checkout/widget/order_summary_text_widget.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.dleeveryFees,
    required this.total,
    required this.estimatedDeliveryTime,
  });
  final String order, taxes, dleeveryFees, total, estimatedDeliveryTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          OrderSummaryTextWidget(
            orderAmount: 'Order',
            price: order,
            isbold: false,
            isSmall: false,
          ),
          SizedBox(height: 15),
          OrderSummaryTextWidget(
            orderAmount: 'Taxes',
            price: taxes,
            isbold: false,
            isSmall: false,
          ),
          SizedBox(height: 15),
          OrderSummaryTextWidget(
            orderAmount: 'Delevery fees',
            price: dleeveryFees,
            isbold: false,
            isSmall: false,
          ),
          Divider(),
          Gap(10),
          OrderSummaryTextWidget(
            orderAmount: 'Total',
            price: total,
            isbold: true,
            isSmall: false,
          ),
          Gap(10),
          OrderSummaryTextWidget(
            orderAmount: 'Estimated delivery time:',
            price: '$estimatedDeliveryTime min',
            isbold: true,
            isSmall: true,
          ),
        ],
      ),
    );
  }
}
