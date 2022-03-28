import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/model/api/forgot_accept_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/auth/reset_password_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';
import '../../dialog/bottom_dialog.dart';
import '../../resources/repository.dart';

class ResetPassVerificationScreen extends StatefulWidget {
  final String email;

  ResetPassVerificationScreen({required this.email});

  @override
  _ResetPassVerificationScreenState createState() =>
      _ResetPassVerificationScreenState();
}

class _ResetPassVerificationScreenState
    extends State<ResetPassVerificationScreen> {
  final _pinPutFocusNode = FocusNode();
  final _pinPutController = TextEditingController();
  Repository _repository = Repository();
  bool _isLoading = false;
  bool success = false;
  int timer = 120;
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: AppTheme.white,
    border: Border.all(color: AppTheme.gray),
    borderRadius: BorderRadius.circular(16),
  );

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
          'Code Verification',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
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
                        'Enter the 4 digits code that you received on your email so you can continue to reset your account password. (Check your spam mails if you cannot find the mail)',
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
                SizedBox(height: 8),
                timer > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            timer.toString() + ' s.',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                              height: 1.8,
                              color: AppTheme.black,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 40),
                Container(
                  child: PinPut(
                    eachFieldWidth: 68,
                    eachFieldHeight: 72,
                    withCursor: false,
                    fieldsCount: 4,
                    onSubmit: (String pin) {
                      _initPinPut(pin);
                    },
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.scale,
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppTheme.fontFamily,
                      height: 1.4,
                      color: AppTheme.black,
                    ),
                  ),
                ),
                timer == 0
                    ? Column(
                        children: [
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Did not get the code? ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  height: 1.5,
                                  fontFamily: AppTheme.fontFamily,
                                  color: AppTheme.dark.withOpacity(0.6),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    timer = 120;
                                  });
                                  _startTimer();
                                },
                                child: Text(
                                  'Send Again',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1.5,
                                    fontFamily: AppTheme.fontFamily,
                                    color: AppTheme.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 44),
                GestureDetector(
                  onTap: () {
                    if (success == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ResetPasswordScreen();
                          },
                        ),
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
          _isLoading == true
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

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        timer--;
        if (timer == 0) {
          _timer!.cancel();
        }
        setState(() {});
      },
    );
  }

  Future<void> _initPinPut(String pin) async {
    setState(() {
      _isLoading = true;
    });
    var response = await _repository.fetchForgotAccept(
      widget.email,
      pin,
    );
    var result = ForgotAcceptModel.fromJson(response.result);

    if (response.isSuccess) {
      setState(() {
        _isLoading = false;
      });
      if (result.status == 1) {
        setState(() {
          success = true;
        });
        _repository.cacheToken(result.token);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ResetPasswordScreen();
            },
          ),
        );
      } else {
        BottomDialog.showAction(
          context,
          'Verification failed',
          'Something went wrong, Please try again after some time',
          'assets/icons/alert.svg',
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      BottomDialog.showAction(
        context,
        'No Internet',
        response.status == -1
            ? 'Connection Failed'
            : 'You do not have internet connection, please try again',
        'assets/icons/alert.svg',
      );
    }
  }
}
