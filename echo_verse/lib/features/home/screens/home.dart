import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/padding_radius_size.dart';
import 'package:echo_verse/core/routes/route_names.dart';

import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Container(
                  margin: EdgeInsets.only(right: 2.w),
                  alignment: Alignment.center,
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: lightGrey),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(CupertinoIcons.search))),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(2.5.w, top, 2.5.w, bottom),
          child: Column(
            children: [
              FutureBuilder<List<UserModel>>(
                future: homeServices.fetchUsersInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                        child: customSnackBar.snackBar(
                            context,
                            'an unexpected error occurred.',
                            ContentType.failure,
                            'Error'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  }
                  final users = snapshot.data;
                  // Filter out the current user
                  final filteredUsers =
                      users!.where((e) => e.authId != userUid).toList();
                  if (users.length == 1) {
                    return Center(child: Text('No messeges available'));
                  }

                  return ListView.separated(
                    physics: ClampingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 1.6.h,
                      );
                    },
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      UserModel user = filteredUsers[index];
                      return MessegeCardWidget(
                        userName: user.name!,
                        messege:
                            'Hi pk, you got offer from google as an software engineer',
                        data: '12 Dec',
                        avatarPath: user.imageUrl == null
                            ? 'lib/assets/logo/robo.png'
                            : user.imageUrl.toString(),
                        onTap: () {
                          context.push(extra: user, RoutePath.chat);
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessegeCardWidget extends StatelessWidget {
  const MessegeCardWidget({
    super.key,
    required this.userName,
    required this.messege,
    required this.data,
    required this.avatarPath,
    required this.onTap,
  });
  final String userName;
  final String messege;
  final String data;
  final String avatarPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: lightGrey.withAlpha(30),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 3.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  spacing: 3.w,
                  children: [
                    CircleAvatarWidget(
                      avatarPath: avatarPath,
                      radius: 32,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            userName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            softWrap: true,
                            messege,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.2.h),
                child: Text(
                  data,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 17.2.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
    required this.avatarPath,
    required this.radius,
  });
  final double radius;

  final String avatarPath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: radius,
      foregroundImage: AssetImage(avatarPath),
    );
  }
}
