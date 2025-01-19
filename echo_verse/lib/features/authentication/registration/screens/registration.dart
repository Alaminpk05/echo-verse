import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/core/utils/validation/auth_validator.dart';
import 'package:echo_verse/features/authentication/widget/auth_widget.dart';
import 'package:echo_verse/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  text: 'Create a new account',
                ),
                SizedBox(height: 2.3.h),
                LoginOrSignUpPageNavigateButton(
                  text: 'Already have an account?',
                  title: 'Login',
                  onTap: () {
                    context.go(RouteNames.login);
                  },
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
                        hintText: 'Name',
                        suffixIcon: null,
                        showEyeIcon: false,
                        prefixIcon: name,
                        controller: nameController,
                        validator: (String? value) {
                          return AuthValidator.validateName(value ?? "");
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      AuthTextField(
                        hintText: 'Email',
                        suffixIcon: email,
                        showEyeIcon: false,
                        prefixIcon: email,
                        controller: emailController,
                        validator: (String? value) {
                          return AuthValidator.validateEmail(value ?? "");
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      AuthTextField(
                        hintText: 'Password',
                        suffixIcon: visibilityOn,
                        showEyeIcon: true,
                        onTap: () {},
                        prefixIcon: key,
                        controller: passwordController,
                        validator: (String? value) {
                          return AuthValidator.validatePassword(value ?? "");
                        },
                      ),
                      SizedBox(height: 10.h),
                      LoginOrSignUpButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            debugPrint('Clicked');
                          }
                        },
                        title: 'Sign Up',
                      ),
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
