import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/checkout/view/checkout_view.dart';
import 'package:hangry_app/shared/custom_button.dart';
import 'package:hangry_app/shared/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final int itemCount = 6;
  late List<int> quantities;

  @override
  void initState() {
    super.initState();
    quantities = List<int>.filled(itemCount, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/cart/cart_item.png',
                                    width: 100,
                                  ),
                                  CustomText(
                                    text: 'Hamberger',
                                    fontWeight: FontWeight.w500,
                                    size: 18,
                                  ),
                                  CustomText(text: 'Viggi berger'),
                                  Gap(15),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (quantities[index] >= 1) {
                                              quantities[index]--;
                                            }
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          child: Icon(
                                            CupertinoIcons.minus,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Gap(20),
                                      CustomText(
                                        text: quantities[index].toString(),
                                        size: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Gap(20),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            quantities[index]++;
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          child: Icon(
                                            CupertinoIcons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(15),
                                  CustomButton(
                                    text: 'Remove',
                                    height: 40,
                                    width: 130,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Gap(100),
        ],
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
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total', size: 17),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CheckoutView();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: CustomText(text: 'Checkout', color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
