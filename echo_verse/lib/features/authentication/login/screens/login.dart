import 'package:echo_verse/features/authentication/widget/auth_widget.dart';
import 'package:echo_verse/core/constant/const_string.dart';
import 'package:echo_verse/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LogoWidget(),
                SizedBox(height: 3.h),
                HeaderTextWidget(
                  text: 'Login to your account',
                ),
                SizedBox(height: 2.3.h),
                LoginOrSignUpPageNavigateButton(
                  text: 'Don’t have an account?',
                  title: 'Sign Up',
                  type: loginPage,
                ),
                SizedBox(
                  height: 4.5.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AuthTextField(
                        hintText: 'Email',
                        suffixIcon: email,
                        showEyeIcon: false,
                        prefixIcon: email,
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      AuthTextField(
                        hintText: 'Password',
                        suffixIcon: visibilityOn,
                        showEyeIcon: true,
                        onTap: () {},
                        prefixIcon: key,
                        controller: passwordController,
                      ),
                      SizedBox(height: 1.5.h),
                      ForgetPasswordButton(),
                      SizedBox(height: 2.h),
                      LoginOrSignUpButton(
                        title: 'Login',
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      LoginWithText(),
                      SizedBox(
                        height: 3.h,
                      ),
                      SignInWithButtons()
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                TermsAndPrivacyButtons()
              ],
            ),
          ),
        ));
  }
}
