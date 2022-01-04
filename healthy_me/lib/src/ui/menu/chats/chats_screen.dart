import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/defaults/doctors_list.dart';
import 'package:healthy_me/src/model/chat_model.dart';
import 'package:healthy_me/src/model/msg_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/chats/all_chats.dart';
import 'package:healthy_me/src/ui/menu/chats/unread_chats_screen.dart';

List<ChatModel> chats = [
  ChatModel(
    user: doc_02,
    msg: [MsgModel(msg: 'Are you feeling good now?', time: DateTime.now())],
    isRead: true,
  ),
  ChatModel(
    user: doc_03,
    msg: [
      MsgModel(
        msg: 'Good afternoon, is there anything I can help you with?',
        time: DateTime.now(),
      )
    ],
    isRead: true,
  ),
  ChatModel(
    user: doc_04,
    msg: [
      MsgModel(msg: 'Good afternoon', time: DateTime.now()),
      MsgModel(msg: 'What disease do you have?', time: DateTime.now())
    ],
    isRead: true,
  ),
  ChatModel(
    user: doc_05,
    msg: [MsgModel(msg: 'How can I help you?', time: DateTime.now())],
  ),
  ChatModel(
    user: doc_06,
    msg: [MsgModel(msg: 'Hello, How are you doing?', time: DateTime.now())],
  ),
  ChatModel(
    user: doc_07,
    msg: [MsgModel(msg: 'Hi there!', time: DateTime.now())],
  ),
];

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.white,
          brightness: Brightness.light,
          title: Text(
            'Messages',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: AppTheme.fontFamily,
              height: 1.5,
              color: AppTheme.black,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 3,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.5,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.5,
            ),
            indicatorColor: AppTheme.purple,
            labelColor: AppTheme.purple,
            unselectedLabelColor: AppTheme.dark,
            tabs: [
              Tab(
                child: Container(
                  width: (MediaQuery.of(context).size.width - 48) / 2.5,
                  child: Center(
                    child: Text(
                      'All',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  width: (MediaQuery.of(context).size.width - 48) / 2.5,
                  child: Center(
                    child: Text(
                      'Unread',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            AllChatsScreen(),
            UnreadChatsScreen(),
          ],
        ),
      ),
    );
  }
}
