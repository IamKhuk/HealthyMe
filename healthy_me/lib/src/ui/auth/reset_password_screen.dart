import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/auth/login_screen.dart';
import 'package:healthy_me/src/utils/utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _passController = new TextEditingController();
  TextEditingController _passAgainController = new TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 64,
        leading: Row(
          children: [
            SizedBox(width: 24),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
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
        centerTitle: false,
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: GestureDetector(
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
            SizedBox(height: 48),
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
            SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Enter your email for the verification process, and we will send 4 digits code to your email for the verification.',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      height: 1.8,
                      color: AppTheme.dark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
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
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Confirm Password',
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
                  controller: _passAgainController,
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
                    hintText: 'Confirm your password',
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
                          color:
                              obscure == true ? AppTheme.gray : AppTheme.purple,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 44),
            GestureDetector(
              onTap: () {
                Utils.passwordValidator(_passController.text) == false &&
                        _passController.text != _passAgainController.text
                    ? BottomDialog.showPassFailed(context)
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
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
                    'Continue',
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
    );
  }
}
