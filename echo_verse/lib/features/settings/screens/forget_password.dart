import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/const_string.dart';
import 'package:echo_verse/core/constant/icons.dart';
import 'package:echo_verse/core/utils/validation/auth_validator.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/widget/auth_widget.dart';
import 'package:echo_verse/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key, required this.type});
  final String type;

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _textController = TextEditingController();

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
              widget.type == resetPassword
                  ? 'Forgot password'
                  : widget.type == changeName
                      ? changeName
                      : widget.type == changeEmail
                          ? changeEmail
                          : widget.type == changePassword
                              ? changePassword
                              : 'Delete Account',
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
                widget.type == resetPassword
                    ? "No worries, we'll send you reset instructions."
                    : widget.type == changeName
                        ? 'Enter your new name'
                        : widget.type == changeEmail
                            ? 'Enter your new email'
                            : widget.type == changePassword
                                ? 'Enter your new password'
                                : 'Enter your password for authentication',
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
              hintText:
                  widget.type == resetPassword || widget.type == changeEmail
                      ? 'Email'
                      : widget.type == changeName
                          ? 'Name'
                          : 'Password',
              showEyeIcon: false,
              prefixIcon: widget.type == resetPassword ? email : key,
              controller: _textController,
              validator: (String? value) {
                return widget.type == resetPassword ||
                        widget.type == changeEmail
                    ? AuthValidator.validateEmail(value ?? "")
                    : widget.type == changeName
                        ? AuthValidator.validateName(value ?? '')
                        : AuthValidator.validatePassword(value ?? "");
              },
              type: '',
            ),
            SizedBox(
              height: 4.h,
            ),
            BlocListener<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingsSuccessState) {
                  customSnackBar.snackBar(
                      context,
                      'Successfully changed your property',
                      ContentType.success,
                      'Siccess');
                  context.pop();
                } else if (state is SettingsErrorState) {
                  customSnackBar.snackBar(context, state.errorMessege,
                      ContentType.failure, 'Error');
                } else if (state is SendEmailState) {
                  customSnackBar.snackBar(
                      context,
                      "An email has been sent to your inbox.",
                      ContentType.success,
                      'Success');
                  context.pop();
                } else if (state is AccountDeleteState) {
                  customSnackBar.snackBar(
                      context,
                      "Your account has been successfully deleted.",
                      ContentType.success,
                      'Success');
                  context.pop();
                }
              },
              child: LoginOrSignUpButton(
                title: widget.type == resetPassword
                    ? 'Send'
                    : widget.type == accountDelete
                        ? 'Delete'
                        : 'Change',
                onTap: () {
                  widget.type == changeName
                      ? context
                          .read<SettingsBloc>()
                          .add(ChangeNameEvent(name: _textController.text))
                      : widget.type == changeEmail
                          ? context.read<SettingsBloc>().add(
                              ChangeEmailEvent(email: _textController.text, password: '',))
                          : widget.type == changePassword
                              ? context.read<SettingsBloc>().add(
                                  ChangePasswordEvent(
                                      password: _textController.text, currentPassword: ''))
                              : widget.type == resetPassword
                                  ? context.read<SettingsBloc>().add(
                                      PasswordResetEvent(
                                          email: _textController.text))
                                  : context.read<SettingsBloc>().add(
                                      DeleteAccountEvent(
                                          password: _textController.text));
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextButton.icon(
                onPressed: () {
                  context.pop();
                },
                label: Text(
                  'Back',
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
