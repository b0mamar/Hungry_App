import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/auth/view/profile_view.dart';
import 'package:hangry_app/features/auth/widget/card_item.dart';
import 'package:hangry_app/features/products/view/product_details_view.dart';
import 'package:hangry_app/shared/custom_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

int selectedIndex = 0;

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              floating: false,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 175,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: EdgeInsetsGeometry.only(top: 38, right: 20, left: 20),
                child: Column(
                  children: [
                    Gap(10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/logo/logo.svg',
                              color: AppColors.primaryColor,
                              height: 35,
                            ),
                            Gap(5),
                            CustomText(
                              text: 'Hello and Welcom to Hungry App',
                              size: 15,
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProfileView();
                                },
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 26,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Gap(15),
                    Material(
                      shadowColor: Colors.grey.shade500,
                      elevation: 3,
                      borderRadius: BorderRadius.circular(20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(CupertinoIcons.search),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Gap(15),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(catigories.length, (index) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = index;
                        }),
                        child: Container(
                          margin: EdgeInsets.only(right: 10, bottom: 10),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CustomText(
                            text: catigories[index],
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: 6, (
                  context,
                  index,
                ) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsView();
                          },
                        ),
                      );
                    },
                    child: CardItem(
                      image: 'assets/test/test.png',
                      bergerName: 'CheeseBerger',
                      bergerDesc: "wendy's berger",
                      rating: '4.9',
                    ),
                  );
                }),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,

                  childAspectRatio: 0.80,
                  mainAxisSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> catigories = ['All', 'Combos', 'Sliders', 'Classic'];
}
