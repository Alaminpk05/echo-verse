import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/padding_radius_size.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 3.w,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/assets/logo/robo.png'),
              radius: 19.sp,
              child: Stack(
                children: [
                  Positioned(
                      right: 0,
                      bottom: 4,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: userActiveColor,
                      ))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Active now',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.phone)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.video_camera,
                size: 28,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: vertical),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [],
            )),
            SizedBox(
              height: 3.h,
            ),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.link)),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      minLines: 1,
                      maxLines: 3,
                      cursorWidth: 1.5,
                      cursorHeight: 2.5.h,
                      decoration: InputDecoration(
                          fillColor: extraLightGrey,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.sp, horizontal: 12.sp),
                          hintText: 'write a messege',
                          border: InputBorder.none,
                          enabled: true,
                          suffixIconColor: teal,
                          hintStyle: TextStyle(
                              color: lightGrey,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'OpenSans'),
                          focusedErrorBorder: OutlineInputBorder(
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
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(CupertinoIcons.camera)),
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.mic)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
