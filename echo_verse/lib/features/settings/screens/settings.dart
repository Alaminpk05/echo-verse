import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:echo_verse/core/constant/const_string.dart';
import 'package:echo_verse/core/constant/icon_and_text_list.dart';
import 'package:echo_verse/core/constant/padding_radius_size.dart';
import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:echo_verse/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    context.read<SettingsBloc>().add(ChangeNameEvent(name: userName!));
    context.read<SettingsBloc>().add(ChangeProfileImage(isChange: false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: top),
        child: Center(
          child: Column(
            children: [
              BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {
                  if (state is SettingsErrorState) {
                    customSnackBar.snackBar(context, state.errorMessege,
                        ContentType.failure, 'Error');
                  }
                },
                builder: (context, state) {
                  if (state is ChangeProfileImageState) {
                    return ProfileAvatar(
                    backgroundImage: state.image != null
                            ? NetworkImage(state.image.toString())
                            : state.image == null
                                ? NetworkImage(user!.photoURL.toString())
                                : AssetImage('lib/assets/logo/robo.png'),
                  );
                    //  GestureDetector(
                    //   onTap: () {
                    //     context
                    //         .read<SettingsBloc>()
                    //         .add(ChangeProfileImage(isChange: true));
                    //   },
                    //   child: CircleAvatar(
                    //     radius: 33.sp,
                    //     backgroundImage: state.image != null
                    //         ? NetworkImage(state.image.toString())
                    //         : state.image == null
                    //             ? NetworkImage(user!.photoURL.toString())
                    //             : AssetImage('lib/assets/logo/robo.png'),
                    //     child: Stack(
                    //       children: [
                    //       Positioned(
                    //         bottom: 10,
                    //         right: 3,
                    //         child: CircleAvatar(
                    //           radius: 17.sp,
                    //           backgroundColor: Colors.white,
                    //           child: Icon(
                    //             CupertinoIcons.camera,
                    //             color: Colors.black,
                    //             size: 18,
                    //           ),
                    //         ),
                    //       ),
                    //     ]),
                    //   ),
                    // );
                  }
                  return ProfileAvatar(
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL.toString())
                        : AssetImage('lib/assets/logo/robo.png'),
                  );
                },
              ),
              SizedBox(
                height: 1.2.h,
              ),
              BlocConsumer<SettingsBloc, SettingsState>(
                listener:(context,state){
                  if (state is SettingsErrorState) {
                    customSnackBar.snackBar(context, state.toString(),
                        ContentType.failure, 'Error');
                  }
                },
                builder: (context, state) {
                  String? displayName = user?.displayName;
                  if (state is ChangeNameState && state.user != null) {
                    return Text(
                      displayName ?? 'User',
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  }  
                  return Text(
                    displayName ?? 'User',
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                },
              ),
              Text(
                firebaseAut.currentUser!.email!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 3.h,
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is UnAuthenticatedState) {
                    customSnackBar.snackBar(
                        context,
                        "You have successfully logged out.",
                        ContentType.success,
                        'Success');
                  }
                },
                child: Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 0.8.h,
                      );
                    },
                    itemCount: settingsOptions.length,
                    itemBuilder: (context, index) {
                      final lastIndex = settingsOptions.length - 1;
                      final title = settingsOptions[index]['title'];
                      final icon = settingsOptions[index]['icon'];
                      return ElevatedButton.icon(
                          onPressed: () {
                            if (index == 0) {
                              context.push(RoutePath.forget, extra: changeName);
                            }
                            //  else if (index == 1) {
                            //   context.push(RoutePath.forget,
                            //       extra: changeEmail);
                            // }
                            else if (index == 1) {
                              context.push(RoutePath.forget,
                                  extra: resetPassword);
                            } else if (index == 3) {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(SignOutEvent());
                            } else if (index == lastIndex) {
                              context.push(RoutePath.forget,
                                  extra: accountDelete);
                            }
                          },
                          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: index == lastIndex || index == 0
                                          ? 0.8.h
                                          : 0.35.h)),
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(index == lastIndex
                                          ? settingsMinRadius
                                          : settingButtonMaxRadius),
                                      topRight: Radius.circular(
                                          index == lastIndex ? settingsMinRadius : settingButtonMaxRadius),
                                      bottomLeft: Radius.circular(index == 0 ? settingsMinRadius : settingButtonMaxRadius),
                                      bottomRight: Radius.circular(index == 0 ? settingsMinRadius : settingButtonMaxRadius)))),
                              backgroundColor: WidgetStatePropertyAll(Colors.grey.withAlpha(40))),
                          icon: Icon(
                            icon,
                            size: 24,
                          ),
                          label: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(1.5.h),
                              child: Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 18.5.sp),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.backgroundImage,
  });
  final ImageProvider backgroundImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SettingsBloc>().add(ChangeProfileImage(isChange: true));
      },
      child: CircleAvatar(
        radius: 33.sp,
        backgroundImage: backgroundImage,
        child: Stack(children: [
          Positioned(
            bottom: 10,
            right: 10,
            child: CircleAvatar(
              radius: 17.sp,
              backgroundColor: Colors.white,
              child: Icon(
                CupertinoIcons.camera,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
