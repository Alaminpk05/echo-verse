import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/padding_radius_size.dart';
import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/chat/data/model/messege.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    messageServices.updateActiveStatus(false);
    super.initState();
    SystemChannels.lifecycle.setMessageHandler((message) {
      debugPrint(message);
      if (message.toString().contains('resume')) {
        messageServices.updateActiveStatus(true);
      } else if (message.toString().contains('pause')) {
        messageServices.updateActiveStatus(false);
      }
      return Future.value(message);
    });
  }

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
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: customSnackBar.snackBar(
                            context,
                            'an unexpected error occurred.',
                            ContentType.failure,
                            'Error'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  }
                  final users = snapshot.data;
                  return ListView.separated(
                    physics: ClampingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 1.6.h,
                      );
                    },
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: users!.length,
                    itemBuilder: (context, index) {
                      UserModel user = users[index];
                      return StreamBuilder<ChatMessageModel?>(
                          stream: homeServices.getLastMessage(user),
                          builder: (context, snapshot) {
                            // if (snapshot.connectionState ==
                            //     ConnectionState.waiting) {
                            //   return const CircularProgressIndicator();
                            // }
                            String? message = snapshot.data?.content;
                            Timestamp? dt = snapshot.data?.timestamp;

                            String formattedTime = '';
                            if (dt != null) {
                              DateTime dateTime = dt.toDate();
                              Duration diff =
                                  DateTime.now().difference(dateTime);

                              if (diff.inHours < 24) {
                                formattedTime =
                                    DateFormat('hh:mm a').format(dateTime);
                              } else if (diff.inDays < 7) {
                                int days = diff.inDays;
                                formattedTime = "$days d";
                              } else {
                                int weeks = diff.inDays ~/ 7;
                                formattedTime = "$weeks w";
                              }
                            }
                            return MessegeCardWidget(
                              userName: user.name!,
                              messege: message ?? '',
                              data: formattedTime,
                              // avatarPath: user.imageUrl == null
                              //     ? 'lib/assets/logo/robo.png'
                              //     : user.imageUrl.toString(),
                              onTap: () {
                                context.push(extra: user, RoutePath.chat);
                              }, user: user,
                            );
                          });
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
    // required this.avatarPath,
    required this.onTap,
    required this.user,
  });
  final String userName;
  final String messege;
  final String data;
  final UserModel user;
  // final String avatarPath;
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
                      radius: 32, chatUser: user,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            userName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 0.1.h,
                          ),
                          Text(
                            softWrap: true,
                            messege,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
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
    required this.radius, required this.chatUser,
  });
  final double radius;
  final UserModel chatUser;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: radius,
      foregroundImage: chatUser.imageUrl != null && chatUser.imageUrl!.isNotEmpty
          ? NetworkImage(chatUser.imageUrl!)
          : AssetImage('lib/assets/logo/robo.png'),
    );
  }
}
