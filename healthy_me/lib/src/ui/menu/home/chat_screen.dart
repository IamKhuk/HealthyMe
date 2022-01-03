import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/model/chat_model.dart';
import 'package:healthy_me/src/model/msg_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel data;

  ChatScreen({required this.data});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<MsgModel> chats;
  bool online = false;
  bool onChanged = false;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    chats = widget.data.msg;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          setState(() {
            onChanged = false;
          });
        },
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * ((94) / 812),
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              color: AppTheme.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: 24,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  'assets/icons/left.svg',
                                  color: AppTheme.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              widget.data.user.pfp,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Dr. ' + widget.data.user.name,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                fontFamily: AppTheme.fontFamily,
                                height: 1.5,
                                color: AppTheme.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              online == false ? 'Offline' : 'Online',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                fontFamily: AppTheme.fontFamily,
                                height: 1.5,
                                color: AppTheme.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {},
                            child: Container(
                              color: Colors.transparent,
                              width: 40,
                              height: 40,
                              child: Center(
                                child: Icon(
                                  Icons.call,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {},
                            child: Container(
                              color: Colors.transparent,
                              width: 24,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.more_vert_sharp,
                                    color: AppTheme.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                dragStartBehavior: DragStartBehavior.down,
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.zero,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (BuildContext context, int index) {
                  return chats[index].id == 1
                      ? Column(
                          children: [
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: 24),
                                Text(
                                  chats[index].time.hour.toString() +
                                      ':' +
                                      chats[index].time.minute.toString(),
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: AppTheme.dark,
                                  ),
                                ),
                                SizedBox(width: 24),
                                IntrinsicWidth(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width -
                                              109,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                      color: AppTheme.orangeLight,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 7),
                                          blurRadius: 45,
                                          spreadRadius: 0,
                                          color: Color(0xFF878787)
                                              .withOpacity(0.1),
                                        )
                                      ],
                                    ),
                                    child: SizedBox(
                                      child: Text(
                                        chats[index].msg,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: AppTheme.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 24),
                              ],
                            ),
                            index == chats.length - 1
                                ? SizedBox(height: 16)
                                : Container(),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(height: 16),
                            Row(
                              children: [
                                SizedBox(width: 24),
                                IntrinsicWidth(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width -
                                              109,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                      color: AppTheme.purple,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 7),
                                          blurRadius: 45,
                                          spreadRadius: 0,
                                          color: Color(0xFF878787)
                                              .withOpacity(0.1),
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      chats[index].msg,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.white,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 24),
                                Text(
                                  chats[index].time.hour.toString() +
                                      ':' +
                                      chats[index].time.minute.toString(),
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: AppTheme.gray,
                                  ),
                                ),
                                SizedBox(width: 24),
                              ],
                            ),
                            index == chats.length - 1
                                ? SizedBox(height: 16)
                                : Container(),
                          ],
                        );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 2,
                left: 36,
                right: 36,
                bottom: 24,
              ),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        enabled: true,
                        onChanged: (_text) {
                          setState(() {
                            onChanged = true;
                            if (_controller.text == '') {
                              onChanged = false;
                            }
                          });
                        },
                        controller: _controller,
                        cursorColor: AppTheme.purple,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.72,
                          color: AppTheme.dark,
                        ),
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a message...',
                          hintStyle: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            height: 1.72,
                            color: AppTheme.dark.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      if (_controller.text != '') {
                        chats.add(MsgModel(
                            msg: _controller.text,
                            id: 1,
                            time: DateTime.now()));
                      }
                      setState(() {
                        _controller.text = '';
                      });
                    },
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: onChanged == false
                            ? AppTheme.purple
                            : AppTheme.white,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/send.svg',
                          color: onChanged == false
                              ? AppTheme.white
                              : AppTheme.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
