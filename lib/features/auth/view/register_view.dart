import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/core/network/api_error.dart';
import 'package:hangry_app/features/auth/data/auth_repo.dart';
import 'package:hangry_app/features/auth/view/login_view.dart';
import 'package:hangry_app/root.dart';
import 'package:hangry_app/shared/custom_auth_button.dart';
import 'package:hangry_app/shared/custom_snack_bar.dart';
import 'package:hangry_app/shared/custom_textformfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = await authRepo.registerUser(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      if (user != null) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Root();
            },
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      String errMsg = "error in register";
      setState(() {
        isLoading = false;
      });
      if (e is ApiError) {
        errMsg = e.message;

        // Show error message to user
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errMsg));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  children: [
                    Gap(100),
                    SvgPicture.asset('assets/logo/logo.svg'),
                    Gap(80),
                    CustomTextformfield(
                      hint: 'Name',
                      isPassword: false,
                      controller: nameController,
                    ),
                    Gap(15),
                    CustomTextformfield(
                      hint: 'Email Adress',
                      isPassword: false,
                      controller: emailController,
                    ),
                    Gap(15),
                    CustomTextformfield(
                      hint: 'Password',
                      isPassword: true,
                      controller: passwordController,
                    ),

                    Gap(30),
                    isLoading
                        ? CupertinoActivityIndicator()
                        : CustomAuthButton(
                            text: 'Register',
                            ontap: registerUser,
                          ),
                    Gap(20),
                    CustomAuthButton(
                      text: "Already have account? Login",
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginView();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
