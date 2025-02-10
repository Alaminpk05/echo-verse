import 'package:echo_verse/core/constant/colors.dart';
import 'package:echo_verse/core/constant/padding_radius_size.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/chat/data/model/messege.dart';
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
  final FocusNode textFieldFocusNode=FocusNode();

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

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];

                        ChatMessageModel data = ChatMessageModel.fromJson(
                            doc.data() as Map<String, dynamic>);
                        final bool isSender = data.senderId != userUid;
                        return Align(
                          alignment: isSender
                              ? Alignment.centerLeft
                              : Alignment
                                  .centerRight, // Change to centerRight for sender
                          child: GestureDetector(
                            onLongPress: () {
                              ChatModalSheetWidget(context);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 14),
                              decoration: BoxDecoration(
                                color: Colors
                                    .teal, // Use Colors.teal instead of teal if undefined
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                maxWidth: 70
                                    .w, // Limits max width but allows it to grow
                              ),
                              child: Text(
                                data.content,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
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
                  IconButton(
                      onPressed: () {
                        if (_messageController.text.isNotEmpty) {
                          messageServices.sendMessage(
                              widget.user.authId.toString(),
                              _messageController.text);
                        }
                        _messageController.clear();
                      },
                      icon: Icon(Icons.send)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> ChatModalSheetWidget(BuildContext context) {
    return showModalBottomSheet(  
                                elevation: 1,
                                constraints: BoxConstraints(
                                    maxHeight: 20.h,
                                    maxWidth: double.infinity),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 5.w),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextButton.icon(
                                            style: Theme.of(context).textButtonTheme.style,
                                            
                                            
                                            icon: Icon(Icons.copy),
                                              onPressed: () {},
                                              label: Text('Copy',style: Theme.of(context).textTheme.labelLarge,)),
                                        ),
                                        TextButton.icon(
                                          icon:Icon(Icons.undo_outlined),
                                            onPressed: () {},
                                            label: Text('Unsend',style: Theme.of(context).textTheme.labelLarge,)),
                                      ],
                                    ),
                                  );
                                });
  }
}
