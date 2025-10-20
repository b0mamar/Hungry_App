import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/checkout/view/success_check.dart';
import 'package:hangry_app/features/checkout/widget/order_summary_widget.dart';
import 'package:hangry_app/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String paymentMethod = 'cash';
  bool saveCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CustomText(
              text: 'Order summary',
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            OrderSummaryWidget(
              order: '50.00',
              taxes: '5.00',
              dleeveryFees: '7.00',
              total: '62.00',
              estimatedDeliveryTime: '15-30',
            ),
            Gap(80),
            CustomText(
              text: 'Paymant Method',
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            Gap(20),
            ListTile(
              onTap: () => setState(() => paymentMethod = 'cash'),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              trailing: Radio<String>(
                activeColor: Colors.white,
                value: 'cash',
                groupValue: paymentMethod,
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),
              leading: Image.asset('assets/icons/dollar.png'),
              tileColor: Color(0xff3C2F2F),
              title: CustomText(text: 'Cash on Delevery', color: Colors.white),
            ),
            Gap(15),
            ListTile(
              onTap: () => setState(() => paymentMethod = 'visa'),

              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              trailing: Radio<String>(
                activeColor: Colors.white,
                value: 'visa',
                groupValue: paymentMethod,
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),

              leading: Image.asset('assets/icons/visa.png', width: 60),
              tileColor: Colors.grey.shade400,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Debit Card',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: '3566***** *****05050',
                    color: Colors.grey.shade700,
                    size: 14,
                  ),
                ],
              ),
            ),
            Gap(10),
            Row(
              children: [
                Checkbox(
                  value: saveCheck,
                  onChanged: (value) {
                    setState(() {
                      saveCheck = value!;
                    });
                  },
                  activeColor: Colors.red,
                ),
                CustomText(text: 'Save card details for future payments'),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total Price', size: 17),
                  Row(
                    children: [
                      CustomText(
                        text: '\$',
                        size: 25,
                        color: AppColors.primaryColor,
                      ),
                      CustomText(text: '18,19', size: 20),
                    ],
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await showSuccessDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: CustomText(text: 'Pay Now', color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
