import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/auth/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.purple,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Image.asset(
                        'assets/images/nurse.png',
                        height: 270,
                      ),
                      SizedBox(width: 100),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 110),
                      Image.asset(
                        'assets/images/man_nurse.png',
                        height: 300,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.48 + 17,
                width: MediaQuery.of(context).size.width,
                color: AppTheme.purple,
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Spacer(),
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                width: MediaQuery.of(context).size.width - 32,
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.purpleLight,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Container(
                      height: 51,
                      width: 51,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 51,
                          width: 51,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Complete Health Solution',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 36,
                              color: AppTheme.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Early protection for family health',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              color: AppTheme.white.withOpacity(0.8),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).popUntil(
                              (route) => route.isFirst,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              color: AppTheme.orange,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/right.svg',
                                color: AppTheme.white,
                                height: 24,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
