import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/padding_radius_size.dart';
import 'package:echo_verse/core/utils/helpers/date_time_format.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/chat/data/model/messege.dart';
import 'package:echo_verse/features/home/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
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
  final FocusNode textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 3.w,
          children: [
            CircleAvatar(
              backgroundImage: widget.user.imageUrl != null &&
                      widget.user.imageUrl!.isNotEmpty
                  ? NetworkImage(widget.user.imageUrl!)
                  : AssetImage('lib/assets/logo/robo.png'),
              radius: 19.sp,
              child: Stack(
                children: [
                  widget.user.isOnline
                      ? Positioned(
                          right: 0,
                          bottom: 4,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: userActiveColor,
                          ))
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.w,
                  child: Text(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    widget.user.name!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  widget.user.isOnline
                      ? 'Active now'
                      : formateLastActive(widget.user.lastActive!),
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
        padding:
            EdgeInsets.only(left: 2.w, right: 2.w, bottom: vertical, top: 2.h),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                StreamBuilder(
                  stream: messageServices.receiveMessage(
                      userUid!, widget.user.authId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No messages yet."));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshot.data!.docs[index];
                          final messageId = doc.id;

                          ChatMessageModel data = ChatMessageModel.fromJson(
                              doc.data() as Map<String, dynamic>);
                          final bool isSender = data.senderId == userUid;
                          return GestureDetector(
                            onLongPress: () {
                              chatModalSheetWidget(
                                  message: data.content,
                                  context: context,
                                  receiverId: widget.user.authId!,
                                  senderId: userUid!,
                                  messageId: messageId);
                            },
                            child: Row(
                              mainAxisAlignment: isSender
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                isSender
                                    ? SizedBox.shrink()
                                    : CircleAvatarWidget(
                                        radius: 19.sp,
                                        chatUser: widget.user,
                                      ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.2.h, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .teal, // Use Colors.teal instead of teal if undefined
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(11.sp),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(11.sp),
                                        bottomRight: Radius.circular(11.sp)),
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth: 50.w,
                                  ),
                                  child: Text(
                                    data.content,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            )),
            SizedBox(
              height: 3.h,
            ),
            ChatBottomWidget(
              formKey: _formKey,
              messageController: _messageController,
              onTapCamera: () {},
              onTapSend: () {
                if (_messageController.text.isNotEmpty) {
                  messageServices.sendMessage(widget.user.authId.toString(),
                      _messageController.text.trim());
                }
                _messageController.clear();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> chatModalSheetWidget(
      {required BuildContext context,
      required String messageId,
      required String receiverId,
      required String senderId,
      required String message}) {
    return showModalBottomSheet(
        elevation: 1,
        constraints: BoxConstraints(maxHeight: 20.h, maxWidth: double.infinity),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ChatBottomSheetButtonWidget(
                  icon: Icons.copy,
                  title: 'Copy',
                  onTap: () {
                    messageServices.copyText(
                        context: context, message: message);
                    context.pop();
                  },
                ),
                ChatBottomSheetButtonWidget(
                  icon: Icons.undo_outlined,
                  title: 'Unsend',
                  onTap: () {
                    messageServices.deleteMessage(
                        senderId, receiverId, messageId);
                    context.pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}

class ChatBottomSheetButtonWidget extends StatelessWidget {
  const ChatBottomSheetButtonWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
          style: Theme.of(context).textButtonTheme.style,
          icon: Icon(icon),
          onPressed: onTap,
          label: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          )),
    );
  }
}

class ChatBottomWidget extends StatelessWidget {
  const ChatBottomWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController messageController,
    required this.onTapCamera,
    required this.onTapSend,
  })  : _formKey = formKey,
        _messageController = messageController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _messageController;
  final VoidCallback onTapCamera;
  final VoidCallback onTapSend;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.sp, horizontal: 12.sp),
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
          IconButton(onPressed: onTapCamera, icon: Icon(CupertinoIcons.camera)),
          IconButton(onPressed: onTapSend, icon: Icon(Icons.send)),
        ],
      ),
    );
  }
}
