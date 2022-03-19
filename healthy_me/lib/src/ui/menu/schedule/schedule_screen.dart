import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/defaults/schedules_list.dart';
import 'package:healthy_me/src/model/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/schedule_container.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final PageController _pageController = PageController();
  late List<ScheduleNotModel> canceled;
  late List<ScheduleNotModel> completed;
  int _index = 0;
  late List<ScheduleNotModel> list;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bg,
        brightness: Brightness.light,
        title: Text(
          'Schedule',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListView(
                    padding: EdgeInsets.only(
                      top: 76,
                      bottom: 24,
                      left: 36,
                      right: 36,
                    ),

                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 36),
                  Container(
                    height: 44,
                    width: MediaQuery.of(context).size.width - 72,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5, 9),
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: AppTheme.gray.withOpacity(0.6),
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 0;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 270),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: _index == 0
                                    ? AppTheme.orange
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Upcoming',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: _index == 0
                                        ? AppTheme.white
                                        : AppTheme.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 1;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 270),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: _index == 1
                                    ? AppTheme.orange
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: _index == 1
                                        ? AppTheme.white
                                        : AppTheme.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 2;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 270),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: _index == 2
                                    ? AppTheme.orange
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Canceled',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: _index == 2
                                        ? AppTheme.white
                                        : AppTheme.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 36),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
