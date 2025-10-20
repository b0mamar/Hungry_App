import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/auth/view/profile_view.dart';
import 'package:hangry_app/features/cart/view/cart_view.dart';
import 'package:hangry_app/features/home/view/home_view.dart';
import 'package:hangry_app/features/orderHistory/view/order_history_view.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

late PageController controller;
late List<Widget> screens;
int currentScreen = 0;

class _RootState extends State<Root> {
  @override
  void initState() {
    controller = PageController(initialPage: currentScreen);
    screens = [HomeView(), CartView(), OrderHistoryView(), ProfileView()];
    super.initState();
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool selected = currentScreen == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentScreen = index;
        });
        controller.animateToPage(
          index,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: selected ? 1.18 : 1.0,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Icon(
                icon,
                color: selected ? Colors.white : Colors.grey.shade300,
                size: 24,
              ),
            ),
            SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                color: selected ? Colors.white : Colors.grey.shade300,
                fontSize: selected ? 12 : 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(CupertinoIcons.home, 'Home', 0),
              _buildNavItem(CupertinoIcons.cart, 'Cart', 1),
              _buildNavItem(Icons.local_restaurant, 'Order', 2),
              _buildNavItem(CupertinoIcons.profile_circled, 'Profile', 3),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
      ),
    );
  }
}
