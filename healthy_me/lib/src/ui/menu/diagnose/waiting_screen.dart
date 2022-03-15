import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
String timerSecText = "";
String timerMinText = "";

class WaitingScreen extends StatefulWidget {
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController _controller;
  int timer = 900;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 15),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    _controller =
        AnimationController(vsync: this, duration: Duration(minutes: 15));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        leadingWidth: 76,
        leading: Row(
          children: [
            SizedBox(width: 36),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/left.svg',
                    color: AppTheme.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: Text(
          'Emergency',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // _scaffoldKey.currentState!.openEndDrawer();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/help.svg',
                    color: AppTheme.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 36),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              SizedBox(height: 44),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ambulance arrive in...\nPlease be patient',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 18,
                      color: AppTheme.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 216,
                    width: 216,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.white,
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 216,
                          width: 216,
                          child: CircularProgressIndicator(
                            value: controller.value,
                            semanticsLabel: 'Linear progress indicator',
                            color: Colors.transparent,
                            strokeWidth: 8,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppTheme.red),
                          ),
                        ),
                        Container(
                          height: 210,
                          width: 210,
                          child: Center(
                            child: CountSecDown(
                              animation: StepTween(
                                begin: 900,
                                end: 0,
                              ).animate(_controller),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return MapScreen();
                  //     },
                  //   ),
                  // );
                },
                child: Container(
                  height: 56,
                  margin: EdgeInsets.symmetric(horizontal: 36, vertical: 24),
                  decoration: BoxDecoration(
                    color: AppTheme.red,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'See in Map',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 16,
                        color: AppTheme.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CountSecDown extends AnimatedWidget {
  CountSecDown({required this.animation}) : super(listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    timerSecText =
        '${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    timerMinText =
        '${(clockTimer.inMinutes.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$timerMinText',
            style: TextStyle(
              fontSize: 52,
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.normal,
              height: 1.5,
              color: AppTheme.black,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 3,
                width: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppTheme.black,
                ),
              ),
              SizedBox(height: 3),
              Container(
                height: 3,
                width: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppTheme.black,
                ),
              ),
            ],
          ),
          SizedBox(width: 4),
          Center(
            child: Text(
              '$timerSecText',
              style: TextStyle(
                fontSize: 48,
                fontFamily: AppTheme.fontFamily,
                fontWeight: FontWeight.normal,
                height: 1.5,
                color: AppTheme.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
