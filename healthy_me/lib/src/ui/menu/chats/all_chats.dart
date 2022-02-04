import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/chat_screen.dart';
import 'chats_screen.dart';

class AllChatsScreen extends StatefulWidget {
  @override
  _AllChatsScreenState createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      padding: EdgeInsets.only(top: 18),
      itemBuilder: (context, index) {
        return SwipeActionCell(
          key: ObjectKey(chats[index]),
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
                      chats[index].deleted = delete;
                      if (chats[index].deleted == true) {
                        chats.removeAt(index);
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
                    return ChatScreen(data: chats[index]);
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
                        chats[index].user.pfp,
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
                          'Dr. ' + chats[index].user.name,
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
                          chats[index].msg.last.msg,
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
                  chats[index].isRead == true
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
                                  chats[index].msg.length.toString(),
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
