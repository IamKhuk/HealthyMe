import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/chat_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/chat_screen.dart';
import 'chats_screen.dart';

class UnreadChatsScreen extends StatefulWidget {
  @override
  _UnreadChatsScreenState createState() => _UnreadChatsScreenState();
}

class _UnreadChatsScreenState extends State<UnreadChatsScreen> {
  late List<ChatModel> chat;

  @override
  void initState() {
    chat = chats.where((element) => element.isRead == true).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chat.length,
      padding: EdgeInsets.only(top: 18),
      itemBuilder: (context, index) {
        return SwipeActionCell(
          key: ObjectKey(chat[index]),
          index: index,
          backgroundColor: AppTheme.bg,
          trailingActions: [
            SwipeAction(
              content: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SvgPicture.asset(
                  'assets/icons/trash.svg',
                  color: AppTheme.red,
                ),
              ),
              widthSpace: 76,
              onTap: (CompletionHandler handler) async {
                BottomDialog.showDeleteChat(
                  context,
                  (delete) {
                    setState(() {
                      chat[index].deleted = delete;
                      if (chat[index].deleted == true) {
                        chat.removeAt(index);
                      }
                    });
                  },
                );
                await handler(false);
                setState(() {});
              },
              color: AppTheme.bg,
            ),
          ],
          closeWhenScrolling: true,
          deleteAnimationDuration: 270,
          isDraggable: true,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatScreen(data: chat[index]);
                  },
                ),
              );
            },
            child: Container(
              height: 68,
              color: Colors.transparent,
              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 24,
                right: 24,
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        chat[index].user.pfp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ' + chat[index].user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: AppTheme.fontFamily,
                            height: 1.5,
                            color: AppTheme.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          chat[index].msg.last.msg,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: AppTheme.fontFamily,
                            height: 1.5,
                            color: AppTheme.black.withOpacity(0.8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  chat[index].isRead == true
                      ? Container(
                          width: 50,
                          child: Center(
                            child: Container(
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.purple,
                              ),
                              child: Center(
                                child: Text(
                                  chat[index].msg.length.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    fontFamily: AppTheme.fontFamily,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
