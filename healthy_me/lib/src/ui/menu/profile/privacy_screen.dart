import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../dialog/bottom_dialog.dart';
import '../../../model/api/login_model.dart';
import '../../../resources/repository.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/utils.dart';
import '../../auth/forgot_password_screen.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  TextEditingController _passOldController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _passAgainController = new TextEditingController();
  bool obscure = true;
  bool onLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  color: AppTheme.gray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/left.svg'),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: Text(
          'Privacy&Security',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(24),
            children: [
              Text(
                'Old Password',
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
                    controller: _passOldController,
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
              SizedBox(height: 32),
              Text(
                'New Password',
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
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  if (Utils.passwordValidator(_passController.text) == false &&
                      _passController.text != _passAgainController.text) {
                    BottomDialog.showPassFailed(context);
                  } else {
                    setState(() {
                      onLoading = true;
                    });
                    var response = await Repository().fetchUpdatePass(
                      _passOldController.text,
                      _passController.text,
                    );
                    var result = LoginModel.fromJson(response.result);

                    if (response.isSuccess) {
                      setState(() {
                        onLoading = false;
                      });
                      if (result.status == 1) {
                        Navigator.pop(context);
                      } else {
                        BottomDialog.showAction(
                          context,
                          'Action Failed',
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
                          'Action Failed',
                          'Something went wrong, Please try again after sometime',
                          'assets/icons/alert.svg',
                        );
                      }
                    }
                  }
                },
                child: Container(
                  height: 56,
                  margin: EdgeInsets.all(24),
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
                      'Change',
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
          )
        ],
      ),
    );
  }
}
