import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/auth/view/login_view.dart';
import 'package:hangry_app/shared/custom_auth_button.dart';
import 'package:hangry_app/shared/custom_textformfield.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

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
                    Gap(15),
                    CustomTextformfield(
                      hint: 'Confirm Password',
                      isPassword: true,
                      controller: confirmPasswordController,
                    ),
                    Gap(30),
                    CustomAuthButton(text: 'Register'),
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
