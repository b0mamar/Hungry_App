import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/auth/widget/custom_profile_textfield.dart';
import 'package:hangry_app/shared/custom_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    emailController.text = 'amar@gmail.com';
    nameController.text = 'amar';
    addressController.text = 'Algeria, setif, ouledSaber';
    passwordController.text = 'hhhhhhhhhh';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        bottomSheet: Container(
          color: Colors.white,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    CustomText(text: 'Edit Profile', color: Colors.white),
                    Gap(15),
                    Icon(Icons.edit_document, color: Colors.white),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    CustomText(text: 'LogOut', color: Colors.white),
                    Gap(10),
                    Icon(Icons.logout, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 129,
                  width: 126,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(color: Colors.white, width: 4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Image.asset(
                      'assets/profile/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Gap(30),
              CustomProfileTextfield(
                controller: nameController,
                labelText: 'Name',
                isPassword: false,
              ),
              CustomProfileTextfield(
                controller: emailController,
                isPassword: false,
                labelText: 'Email',
              ),

              CustomProfileTextfield(
                controller: addressController,
                isPassword: false,
                labelText: 'Address-delevry',
              ),

              CustomProfileTextfield(
                controller: passwordController,
                isPassword: true,
                labelText: 'Password',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
