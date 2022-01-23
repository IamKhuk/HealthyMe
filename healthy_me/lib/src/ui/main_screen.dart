import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/diagnose/diagnose_screen.dart';
import 'package:healthy_me/src/ui/menu/profile/profile_screen.dart';
import 'package:healthy_me/src/ui/menu/schedule/schedule_screen.dart';
import 'menu/chats/chats_screen.dart';
import 'menu/home/home_screen.dart';

int selectedIndex = 0;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> data = [
    HomeScreen(),
    ScheduleScreen(),
    DiagnoseScreen(),
    ChatsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          data[selectedIndex],
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 70,
              width: size.width,
              margin: EdgeInsets.only(left: 16, bottom: 16, right: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 9),
                    blurRadius: 30,
                    spreadRadius: 0,
                    color: AppTheme.gray,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width - 32, 70),
                    painter: RPSCustomPainter(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 0),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/home.svg',
                                      color: selectedIndex == 0
                                          ? AppTheme.orange
                                          : AppTheme.dark,
                                    ),
                                    selectedIndex == 0
                                        ? Column(
                                            children: [
                                              SizedBox(height: 8),
                                              Container(
                                                height: 6,
                                                width: 6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: AppTheme.orange,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/schedule.svg',
                                      color: selectedIndex == 1
                                          ? AppTheme.orange
                                          : AppTheme.dark,
                                    ),
                                    selectedIndex == 1
                                        ? Column(
                                            children: [
                                              SizedBox(height: 8),
                                              Container(
                                                height: 6,
                                                width: 6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: AppTheme.orange,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 54,
                              width: 54,
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(54),
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 2;
                                  });
                                },
                                child: Container(
                                  height: 54,
                                  width: 54,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 7),
                                        blurRadius: 9,
                                        spreadRadius: 0,
                                        color: selectedIndex == 2
                                            ? AppTheme.orange
                                            : AppTheme.purple,
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          selectedIndex == 2
                                              ? AppTheme.orange
                                              : AppTheme.purpleLight,
                                          selectedIndex == 2
                                              ? AppTheme.orange
                                              : AppTheme.purple,
                                          selectedIndex == 2
                                              ? AppTheme.orange
                                              : AppTheme.purple,
                                          selectedIndex == 2
                                              ? AppTheme.orange
                                              : AppTheme.purple,
                                          selectedIndex == 2
                                              ? AppTheme.orange
                                              : AppTheme.purple,
                                        ]),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/diagnose.svg',
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 3;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/message.svg',
                                      color: selectedIndex == 3
                                          ? AppTheme.orange
                                          : AppTheme.dark,
                                    ),
                                    selectedIndex == 3
                                        ? Column(
                                            children: [
                                              SizedBox(height: 8),
                                              Container(
                                                height: 6,
                                                width: 6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: AppTheme.orange,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 4;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/account.svg',
                                      color: selectedIndex == 4
                                          ? AppTheme.orange
                                          : AppTheme.dark,
                                    ),
                                    selectedIndex == 4
                                        ? Column(
                                            children: [
                                              SizedBox(height: 8),
                                              Container(
                                                height: 6,
                                                width: 6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: AppTheme.orange,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 32),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0625000, size.height);
    path0.quadraticBezierTo(size.width * -0.0010125, size.height * 0.9993333, 0,
        size.height * 0.6666667);
    path0.cubicTo(0, size.height * 0.5833333, 0, size.height * 0.4166667, 0,
        size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.0000500, size.height * 0.0005333,
        size.width * 0.0625000, 0);
    path0.quadraticBezierTo(
        size.width * 0.2968750, 0, size.width * 0.3750000, 0);
    path0.quadraticBezierTo(size.width * 0.4374375, size.height * 0.0003333,
        size.width * 0.4375000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.4376250, size.height * 0.6663333,
        size.width * 0.5000000, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.5624125, size.height * 0.6663333,
        size.width * 0.5625000, size.height * 0.3333333);
    path0.quadraticBezierTo(size.width * 0.5635750, size.height * 0.0003333,
        size.width * 0.6250000, 0);
    path0.quadraticBezierTo(
        size.width * 0.7031250, 0, size.width * 0.9375000, 0);
    path0.quadraticBezierTo(size.width * 0.9999750, size.height * 0.0002667,
        size.width, size.height * 0.3333333);
    path0.cubicTo(size.width, size.height * 0.4166667, size.width,
        size.height * 0.5833333, size.width, size.height * 0.6666667);
    path0.quadraticBezierTo(size.width * 0.9999375, size.height * 0.9992667,
        size.width * 0.9375000, size.height);
    path0.lineTo(size.width * 0.0625000, size.height);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
