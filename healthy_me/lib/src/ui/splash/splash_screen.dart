import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../main_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? offset;

  @override
  void initState() {
    _nextScreen();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1270),
    )..forward();
    offset = Tween<Offset>(
      begin: Offset(0.0, 4.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.purple,
      body: Stack(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                'assets/icons/splash_up.svg',
                color: AppTheme.purpleLight,
              ),
              Expanded(child: Container()),
              SvgPicture.asset(
                'assets/icons/splash_down.svg',
                color: AppTheme.purpleLight,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: offset!,
                    child: SvgPicture.asset(
                      "assets/icons/logo.svg",
                      height: 112,
                      width: 112,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Spacer(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOADING',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: AppTheme.fontFamily,
                        letterSpacing: 0.14,
                        color: AppTheme.white.withOpacity(0.9),
                      ),
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

  // Future<void> _setLanguage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var lan = prefs.getString('language') ?? "uz";
  //   var localizationDelegate = LocalizedApp.of(context).delegate;
  //   localizationDelegate.changeLocale(Locale(lan));
  // }

  _nextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("firstOpen") != null) {
      isLoginPage = true;
    } else {
      prefs.setString("firstOpen", "value");
      isLoginPage = false;
    }
    token = prefs.getString('token') ?? "";

    Timer(
      Duration(milliseconds: 2270),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return isLoginPage == false
                  ? OnBoardingScreen()
                  : token == ""
                      ? LoginScreen()
                      : MainScreen();
            },
          ),
        );
      },
    );
  }
}
