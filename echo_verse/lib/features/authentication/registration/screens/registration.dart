import 'package:echo_verse/features/authentication/widget/auth_widget.dart';
import 'package:echo_verse/utils/constant/const_string.dart';
import 'package:echo_verse/utils/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
              title: 'Login', type: signUpPage,
            ),
            SizedBox(
              height: 4.5.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AuthTextField(
                  hintText: 'Name',
                  suffixIcon: null,
                  showEyeIcon: false,
                  prefixIcon: name,
                ),
                 SizedBox(
                  height: 3.h,
                ),
                AuthTextField(
                  hintText: 'Email',
                  suffixIcon: email,
                  showEyeIcon: false,
                  prefixIcon: email,
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
                ),
                SizedBox(height: 10.h),
                LoginOrSignUpButton(
                  title: 'Sign Up',
                ),
                
              ],
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


