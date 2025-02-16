import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/const_string.dart';

import 'package:echo_verse/core/constant/icons.dart';

import 'package:echo_verse/features/settings/bloc/settings_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class LoginOrSignUpPageNavigateButton extends StatelessWidget {
  const LoginOrSignUpPageNavigateButton({
    super.key,
    required this.text,
    required this.title,
    required this.onTap,
  });
  final String text;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        InkWell(
          splashColor: white,
          highlightColor: white,
          borderRadius: BorderRadius.circular(16.sp),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.1.h),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: teal),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderTextWidget extends StatelessWidget {
  const HeaderTextWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextTheme.of(context).headlineLarge);
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'lib/assets/logo/robo.png',
        fit: BoxFit.contain,
        width: 64,
        height: 64,
      ),
    );
  }
}

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        'Forget Password?',
        textAlign: TextAlign.right,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: teal),
      ),
    );
  }
}

class LoginOrSignUpButton extends StatelessWidget {
  const LoginOrSignUpButton({
    super.key,
    required this.title,
    this.onTap,
  });
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.5.h,
      child: ElevatedButton(
          onPressed: onTap,
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoadingState) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              return Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: white),
              );
            },
          )),
    );
  }
}

class LoginWithText extends StatelessWidget {
  const LoginWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Divider(
            color: lightGrey.withValues(alpha: 0.8),
            thickness: 0.3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            'Or login with',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          flex: 2,
          child: Divider(
            color: lightGrey.withValues(alpha: 0.8),
            thickness: 0.3,
          ),
        )
      ],
    );
  }
}

class SignInWithButtons extends StatelessWidget {
  const SignInWithButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AuthSignInWithButtonWidget(
          image: 'lib/assets/icons/google.png',
          title: 'Google',
        ),
        AuthSignInWithButtonWidget(
          image: 'lib/assets/icons/facebook.png',
          title: 'Facebook',
        ),
      ],
    );
  }
}

class TermsAndPrivacyButtons extends StatelessWidget {
  const TermsAndPrivacyButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            child: Text(
              'Terms of use',
              style: Theme.of(context).textTheme.labelSmall,
            )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          color: lightGrey,
          height: 1.5.h,
          width: 1,
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Privacy policy',
              style: Theme.of(context).textTheme.labelSmall,
            )),
      ],
    );
  }
}

class AuthSignInWithButtonWidget extends StatelessWidget {
  const AuthSignInWithButtonWidget({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Image.asset(
          image,
          width: 24,
          height: 24,
        ),
        style: Theme.of(context)
            .elevatedButtonTheme
            .style!
            .copyWith(backgroundColor: WidgetStatePropertyAll(deepWhite)),
        onPressed: () {},
        label: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ));
  }
}

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.showEyeIcon,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    required this.type,
  });
  final TextEditingController controller;
  final String hintText;

  final IconData prefixIcon;
  final bool showEyeIcon;

  final String? Function(String?)? validator;
  final String? type;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.type == password ? _obscureText : false,
      controller: widget.controller,
      validator: widget.validator,
      cursorWidth: 1.5,
      cursorHeight: 2.5.h,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabled: true,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: lightGrey,
          ),
          suffixIcon: widget.showEyeIcon
              ? IconButton(
                  onPressed: _toggleVisibility,
                  icon: Icon(_obscureText ? visibilityOff : visibilityOn))
              : null,
          suffixIconColor: teal,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: lightGrey,
              fontWeight: FontWeight.normal,
              fontFamily: 'OpenSans'),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: authTextFieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(17.sp)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: authTextFieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(17.sp)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: authTextFieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(17.sp)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: authTextFieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(17.sp))),
    );
  }
}
