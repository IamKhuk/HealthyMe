import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/schedule/schedules_canceled.dart';
import 'package:healthy_me/src/ui/menu/schedule/schedules_completed.dart';
import 'package:healthy_me/src/ui/menu/schedule/schedules_upcoming.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final PageController _pageController = PageController();
  int _index = 0;

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
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height-84,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),

                  children: [
                    UpcomingSchedules(),
                    CompletedSchedules(),
                    CanceledSchedules(),
                  ],
                ),
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
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
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
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
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
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
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
