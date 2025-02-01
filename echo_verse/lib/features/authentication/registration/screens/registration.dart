import 'package:echo_verse/core/constant/const_string.dart';
import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/core/utils/validation/auth_validator.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:echo_verse/features/authentication/widget/auth_widget.dart';
import 'package:echo_verse/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        showEyeIcon: false,
                        prefixIcon: name,
                        controller: nameController,
                        validator: (String? value) {
                          return AuthValidator.validateName(value ?? "");
                        }, type: '',
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      AuthTextField(
                        hintText: 'Email',
                        showEyeIcon: false,
                        prefixIcon: email,
                        controller: emailController,
                        validator: (String? value) {
                          return AuthValidator.validateEmail(value ?? "");
                        }, type: '',
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          return AuthTextField(
                            hintText: 'Password',
                            showEyeIcon: true,
                            prefixIcon: key,
                            controller: passwordController,
                            validator: (String? value) {
                              return AuthValidator.validatePassword(
                                  value ?? "");
                            }, type: password,
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      BlocListener<AuthenticationBloc, AuthenticationState>(
                        listener: (context, state) {
                          if (state is AuthenticationErrorState) {
                            customSnackBar.snackBar(
                                context, state.errorMessege);
                          }
                        },
                        child: LoginOrSignUpButton(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthenticationBloc>().add(
                                  SignUpEvent(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text));
                              debugPrint('Clicked');
                            }
                          },
                          title: 'Sign Up',
                        ),
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
