import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/icons.dart';
import 'package:echo_verse/core/utils/validation/auth_validator.dart';
import 'package:echo_verse/features/authentication/widget/auth_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot password',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 23.sp),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "No worries, we'll send you reset instructions.",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            AuthTextField(
              hintText: 'Email',
              showEyeIcon: false,
              prefixIcon: email,
              controller: _emailController,
              validator: (String? value) {
                return AuthValidator.validateEmail(value ?? "");
              },
              type: '',
            ),
            SizedBox(
              height: 4.h,
            ),
            LoginOrSignUpButton(
              title: 'Send',
              onTap: () {},
            ),
            SizedBox(
              height: 2.h,
            ),
            TextButton.icon(
                onPressed: () {
                  context.pop();
                },
                label: Text(
                  'Back to log in',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: lightGrey),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: lightGrey,
                ))
          ],
        ),
      ),
    );
  }
}
