import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/core/network/api_error.dart';
import 'package:hangry_app/features/auth/data/auth_repo.dart';
import 'package:hangry_app/features/auth/view/register_view.dart';
import 'package:hangry_app/root.dart';
import 'package:hangry_app/shared/custom_auth_button.dart';
import 'package:hangry_app/shared/custom_snack_bar.dart';
import 'package:hangry_app/shared/custom_text.dart';
import 'package:hangry_app/shared/custom_textformfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool _isLoading = false;

class _LoginViewState extends State<LoginView> {
  AuthRepo authRepo = AuthRepo();
  Future<void> loginUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await authRepo.loginUser(
        emailController.text,
        passwordController.text,
      );
      if (user.token != null) {
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
        _isLoading = false;
      });
    } catch (e) {
      String errMsg = "error in login";
      setState(() {
        _isLoading = false;
      });
      if (e is ApiError) {
        errMsg = e.message;
        if (!mounted) return;
        // Show error message to user
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errMsg));

      // Handle login error
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  child: Column(
                    children: [
                      Gap(100),
                      SvgPicture.asset('assets/logo/logo.svg'),
                      Gap(10),
                      CustomText(
                        text: 'Welcom back, discover the best fast food',
                        color: Colors.white,
                        size: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      Gap(70),
                      CustomTextformfield(
                        hint: 'Email address',
                        isPassword: false,
                        controller: emailController,
                      ),
                      Gap(20),
                      CustomTextformfield(
                        hint: 'Password',
                        isPassword: true,
                        controller: passwordController,
                      ),
                      Gap(30),
                      _isLoading
                          ? CupertinoActivityIndicator()
                          : CustomAuthButton(text: 'Login', ontap: loginUser),
                      Gap(20),
                      CustomAuthButton(
                        text: "Dont have an account? Sign Up",
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterView();
                              },
                            ),
                          );
                        },
                      ),
                      Gap(20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Root();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Continue as Guest',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
