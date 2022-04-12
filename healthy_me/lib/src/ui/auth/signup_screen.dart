import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/api/register_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/auth/verification_screen.dart';
import 'package:healthy_me/src/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  Repository _repository = Repository();

  bool obscure = true;
  String userName = '';
  int phone = 0;
  String password = '';
  bool onLoading = false;

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
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                    SizedBox(width: 26),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Sign Up',
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
                        hintText: 'Create your username',
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
                  'Email Address',
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
                      controller: _emailController,
                      enableSuggestions: true,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppTheme.purple,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.emailAddress,
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
                        hintText: 'Enter your email address',
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
                        hintText: 'Create your password',
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
                SizedBox(height: 48),
                GestureDetector(
                  onTap: () async {
                    String email = _emailController.text.replaceAll(' ', '');
                    if (_userController.text.length > 0) {
                      if (Utils.emailValidator(email) == true) {
                        if (_passController.text.length > 0) {
                          if (Utils.passwordValidator(_passController.text) ==
                              true) {
                            setState(() {
                              onLoading = true;
                            });
                            var response = await _repository.fetchRegister(
                              _userController.text,
                              _passController.text,
                              email,
                            );
                            var result = RegisterModel.fromJson(
                              response.result,
                            );
                            if (response.isSuccess) {
                              setState(() {
                                onLoading = false;
                              });
                              if (result.status == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return VerificationScreen(
                                        password: _passController.text,
                                        email: email,
                                        username: _userController.text,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                BottomDialog.showAction(
                                  context,
                                  'Sign Up Failed',
                                  result.msg,
                                  'assets/icons/alert.svg',
                                );
                              }
                            } else {
                              setState(() {
                                onLoading = false;
                              });
                              if (response.status == -1) {
                                BottomDialog.showAction(
                                  context,
                                  'Connection Failed',
                                  'You do not have internet connection, please try again',
                                  'assets/icons/alert.svg',
                                );
                              } else {
                                BottomDialog.showAction(
                                  context,
                                  'Login Failed',
                                  result.msg,
                                  'assets/icons/alert.svg',
                                );
                              }
                            }
                          } else {
                            BottomDialog.showPassFailed(context);
                          }
                        } else {
                          BottomDialog.showAction(
                            context,
                            'Invalid Password',
                            'Password is required and cannot be empty',
                            'assets/icons/alert.svg',
                          );
                        }
                      } else {
                        BottomDialog.showAction(
                          context,
                          'Invalid Email Address',
                          'Please enter valid email address so that we can register you correctly',
                          'assets/icons/alert.svg',
                        );
                      }
                    } else {
                      BottomDialog.showAction(
                        context,
                        'Invalid Username',
                        'Please enter valid username that contains more than 2 characters',
                        'assets/icons/alert.svg',
                      );
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
                        'Sign Up',
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
                ),
              ],
            ),
          ),
          onLoading == true
              ? Container(
                  color: AppTheme.black.withOpacity(0.45),
                  child: Center(
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
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
