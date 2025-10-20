import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/products/widget/product_ingredients.dart';
import 'package:hangry_app/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late double _currentValue = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),

      // Add a bottom button that navigates back to HomeView
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/Product_details/product_details.png',
                    height: 300,
                  ),
                  Spacer(),
                  Column(
                    children: [
                      CustomText(
                        text:
                            'Customize Your Burger\n to Your Tastes.\n Ultimate Experience',
                      ),
                      Slider(
                        min: 0,
                        max: 100,
                        divisions: 4,
                        value: _currentValue,
                        onChanged: (double value) {
                          setState(() {
                            _currentValue = value;
                          });
                        },
                        activeColor: AppColors.primaryColor,
                        inactiveColor: Colors.grey.shade300,
                      ),
                      Row(children: [Text('🥶'), Gap(100), Text('🌶️')]),
                    ],
                  ),
                ],
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  fontWeight: FontWeight.bold,
                  text: 'Toppings',
                  size: 23,
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(10),
              SizedBox(
                height: 102,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    return IngredientCard(
                      name: ingredients[index]['name']!,
                      imageAsset: ingredients[index]['Image']!,
                      onAdd: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(15);
                  },
                ),
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  text: 'Side Options',
                  fontWeight: FontWeight.bold,
                  size: 23,
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(20),
              SizedBox(
                height: 102,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return IngredientCard(
                      name: options[index]['name']!,
                      imageAsset: options[index]['Image']!,
                      onAdd: () {},
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(15);
                  },
                ),
              ),
              Gap(110),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 90,
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: CustomText(text: 'Add To Cart', color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map> ingredients = [
    {'name': 'Tomato', 'Image': 'assets/Product_details/tomato.png'},
    {'name': 'onions', 'Image': 'assets/Product_details/onions.png'},
    {'name': 'pickles', 'Image': 'assets/Product_details/pickles.png'},
    {'name': 'Bacon', 'Image': 'assets/Product_details/bacon.png'},
  ];
  final List<Map> options = [
    {'name': 'Fries', 'Image': 'assets/product_options/fries.png'},
    {'name': 'Coleslaw', 'Image': 'assets/product_options/coleslaw.png'},
    {'name': 'Salad', 'Image': 'assets/product_options/salad.png'},
    {'name': 'Onion', 'Image': 'assets/product_options/onion.png'},
  ];
}
