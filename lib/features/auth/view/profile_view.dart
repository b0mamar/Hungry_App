import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/core/network/api_error.dart';
import 'package:hangry_app/features/auth/data/auth_repo.dart';
import 'package:hangry_app/features/auth/data/user_model.dart';
import 'package:hangry_app/features/auth/view/login_view.dart';
import 'package:hangry_app/features/auth/widget/custom_profile_textfield.dart';
import 'package:hangry_app/shared/custom_button.dart';
import 'package:hangry_app/shared/custom_snack_bar.dart';
import 'package:hangry_app/shared/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

TextEditingController emailController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController visaController = TextEditingController();

class _ProfileViewState extends State<ProfileView> {
  bool _isLoading = false;
  bool _isLogoutLoading = false;
  UserModel? userModel;
  bool isGuest = false;
  AuthRepo authRepo = AuthRepo();

  Future<void> autoLogIn() async {
    final user = await authRepo.autoLogIn();
    setState(() {
      isGuest = authRepo.isGuest;
    });
    if (user != null) {
      setState(() {
        userModel = user;
      });
    }
  }

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getUserProfile();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errMsg = "error in fetching profile";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errMsg));
    }
  }

  String? selectedImage;
  Future<void> pickImage() async {
    // Implement image picker logic here
    final pickedImagePath = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImagePath != null) {
      setState(() {
        selectedImage = pickedImagePath.path;
      });
    }
  }

  Future<void> updateProfileData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await authRepo.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        visa: visaController.text.trim(),
        imagePath: selectedImage,
      );
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnackBar('profile updated'));

      setState(() {
        userModel != user;
      });
      await getProfileData();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      String errMsg = "error in fetching profile";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errMsg));
    }
  }

  Future<void> logOut() async {
    setState(() {
      _isLogoutLoading = true;
    });
    await authRepo.logoutUser();
    setState(() {
      _isLogoutLoading = false;
    });
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LoginView();
        },
      ),
    );
  }

  @override
  void initState() {
    autoLogIn();
    getProfileData().then((value) {
      emailController.text = userModel?.email.toString() ?? '';
      nameController.text = userModel?.name.toString() ?? 'not provided';
      addressController.text = userModel?.address == null
          ? 'not provided'
          : userModel!.address!;
      visaController.text = userModel?.visa == null
          ? 'add your visa card'
          : userModel!.visa!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return RefreshIndicator(
        onRefresh: () async {
          return await getProfileData();
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),

          child: Scaffold(
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
              child: Skeletonizer(
                enabled: userModel == null,
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
                          child: selectedImage != null
                              ? Image.file(
                                  File(selectedImage!),
                                  fit: BoxFit.cover,
                                )
                              : (userModel?.image != null &&
                                    userModel!.image!.isNotEmpty)
                              ? Image.network(
                                  fit: BoxFit.cover,
                                  userModel!.image!,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.person);
                                  },
                                )
                              : Icon(Icons.person),
                        ),
                      ),
                    ),
                    Gap(10),
                    CustomButton(
                      text: 'uploade image',
                      height: 40,
                      width: 130,
                      color: const Color.fromARGB(255, 98, 129, 243),
                      radius: 20,
                      onTap: pickImage,
                    ),
                    Gap(10),
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Divider(),
                    ),
                    Gap(10),

                    CustomProfileTextfield(
                      controller: visaController,
                      isPassword: false,
                      labelText: 'visa Card',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: userModel?.visa == null
                          ? Gap(1)
                          : ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),

                              leading: Image.asset(
                                'assets/icons/visa.png',
                                width: 60,
                              ),
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
                                    text:
                                        userModel?.visa ??
                                        '**** **** ***** ****',
                                    color: Colors.grey.shade700,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Gap(200),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              color: Colors.white,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _isLoading
                      ? CupertinoActivityIndicator()
                      : ElevatedButton(
                          onPressed: updateProfileData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? CupertinoActivityIndicator()
                              : Row(
                                  children: [
                                    CustomText(
                                      text: 'Edit Profile',
                                      color: Colors.white,
                                    ),
                                    Gap(15),
                                    Icon(
                                      Icons.edit_document,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                        ),
                  _isLogoutLoading
                      ? CupertinoActivityIndicator()
                      : ElevatedButton(
                          onPressed: logOut,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
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
          ),
        ),
      );
    } else if (isGuest) {
      return Center(child: Text('Guest Mode'));
    }
    return Center(child: CircularProgressIndicator());
  }
}
