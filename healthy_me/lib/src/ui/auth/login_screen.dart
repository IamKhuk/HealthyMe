import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/api/login_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/auth/forgot_password_screen.dart';
import 'package:healthy_me/src/ui/auth/signup_screen.dart';

import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  Repository _repository = Repository();

  bool onLoading = false;

  bool obscure = true;
  String userName = '';
  int phone = 0;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                SizedBox(height: 68),
                Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 64,
                      width: 64,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                color: AppTheme.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 26),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: AppTheme.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  'Username',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                    color: AppTheme.black,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 75,
                        spreadRadius: 0,
                        color: Color(0xFF939393).withOpacity(0.07),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 2,
                    ),
                    child: TextField(
                      enabled: true,
                      controller: _userController,
                      enableSuggestions: true,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppTheme.purple,
                      enableInteractiveSelection: true,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.black,
                      ),
                      autofocus: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.dark.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                    color: AppTheme.black,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 75,
                        spreadRadius: 0,
                        color: Color(0xFF939393).withOpacity(0.07),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 2,
                    ),
                    child: TextField(
                      enabled: true,
                      controller: _passController,
                      enableSuggestions: true,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppTheme.purple,
                      obscureText: obscure,
                      enableInteractiveSelection: true,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.black,
                      ),
                      autofocus: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.dark.withOpacity(0.6),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 14, bottom: 11, left: 22),
                            child: SvgPicture.asset(
                              'assets/icons/eye.svg',
                              color: obscure == true
                                  ? AppTheme.gray
                                  : AppTheme.purple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: 15,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            height: 1.5,
                            color: AppTheme.dark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      onLoading = true;
                    });
                    var response = await _repository.fetchLogin(
                      _userController.text,
                      _passController.text,
                    );
                    var result = LoginModel.fromJson(response.result);

                    if (response.isSuccess) {
                      setState(() {
                        onLoading = false;
                      });
                      if (result.status == 1) {
                        _repository.cacheLoginUser(result);
                        Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MainScreen();
                            },
                          ),
                        );
                      } else {
                        BottomDialog.showActionFailed(
                            context, 'Login Failed', result.msg);
                      }
                    } else {
                      setState(() {
                        onLoading = false;
                      });
                      if (response.status == -1) {
                        BottomDialog.showActionFailed(
                          context,
                          'Connection Failed',
                          'You do not have internet connection, please try again',
                        );
                      } else {
                        BottomDialog.showActionFailed(
                          context,
                          'Login Failed',
                          result.msg,
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppTheme.purple,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 9),
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: AppTheme.gray,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          onLoading == true
              ? Center(
                  child: Container(
                    height: 96,
                    width: 96,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 25,
                          spreadRadius: 0,
                          color: AppTheme.dark.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.purple),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
