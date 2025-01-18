import 'package:echo_verse/utils/constant/colors.dart';
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
        body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.asset(
              'lib/assets/logo/robo.png',
              fit: BoxFit.contain,
              width: 64,
              height: 64,
            ),
          ),
          SizedBox(height: 3.h),
          Text('Login to your account',
              style: TextTheme.of(context).headlineLarge),
          SizedBox(height: 2.3.h),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'Don’t have an account? ',
                style: TextTheme.of(context)
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.w400)),
            TextSpan(
                text: 'Sign Up',
                style:
                    TextTheme.of(context).labelMedium!.copyWith(color: teal)),
          ])),
          SizedBox(
            height: 4.5.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AuthTextFieldWidget(
                hintText: 'Email',
                suffixIcon: email,
                showEyeIcon: false, prefixIcon: email,
              ),
              SizedBox(
                height: 2.h,
              ),
              AuthTextFieldWidget(
                hintText: 'Password',
                suffixIcon: visibilityOn,
                showEyeIcon: true,
                onTap: () {}, prefixIcon: key,
              ),
              SizedBox(height: 3.h),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password?',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: teal),),
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    width: double.infinity,
                    height: 6.5.h,
                    child: ElevatedButton(onPressed: (){},
                     child: Text('Login',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: white),)),
                  )
            ],
          )
        ],
      ),
    ));
  }
}

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    required this.showEyeIcon,
    this.onTap, required this.prefixIcon,
  });
  final String hintText;
  final IconData suffixIcon;
  final IconData prefixIcon;
  final bool showEyeIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorWidth: 1.5,
      cursorHeight: 2.5.h,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabled: true,
          prefixIcon: Icon(
            prefixIcon,
            color: lightGrey,
          ),
          suffixIcon: showEyeIcon
              ? IconButton(onPressed: onTap, icon: Icon(visibilityOn))
              : null,
          suffixIconColor: teal,
          hintText: hintText,
          hintStyle: TextStyle(
              color: lightGrey,
              fontWeight: FontWeight.normal,
              fontFamily: 'OpenSans'),
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
