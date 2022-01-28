import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class BottomDialog {
  static void showDeleteChat(
    BuildContext context,
    Function(bool isDelete) delete,
  ) {
    showModalBottomSheet(
      barrierColor: AppTheme.black.withOpacity(0.45),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 412,
              child: Column(
                children: [
                  Container(
                    height: 316,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                        bottomRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      color: AppTheme.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.gray,
                          ),
                        ),
                        SizedBox(height: 30),
                        SvgPicture.asset(
                          'assets/icons/alert.svg',
                          color: AppTheme.red,
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Delete Chat?',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.72,
                            color: AppTheme.dark,
                          ),
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            'All the messages will be deleted permanently and can’t be restored, are you sure?',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.72,
                              color: AppTheme.dark.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      delete(true);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56,
                      margin: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: AppTheme.fontFamily,
                            height: 1.5,
                            color: AppTheme.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void showPassFailed(
      BuildContext context,
      ) {
    showModalBottomSheet(
      barrierColor: AppTheme.black.withOpacity(0.45),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 432,
              child: Column(
                children: [
                  Container(
                    height: 336,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                        bottomRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      color: AppTheme.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.gray,
                          ),
                        ),
                        SizedBox(height: 30),
                        SvgPicture.asset(
                          'assets/icons/alert.svg',
                          color: AppTheme.red,
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Password is too Weak',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: AppTheme.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            'Password must be at least 8 character long and must contain at least 1 number, 1 Uppercase letter and 1 special character',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.72,
                              color: AppTheme.dark.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56,
                      margin: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'OK, Understood',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: AppTheme.fontFamily,
                            height: 1.5,
                            color: AppTheme.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void showEmailFailed(
      BuildContext context,
      ) {
    showModalBottomSheet(
      barrierColor: AppTheme.black.withOpacity(0.45),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 402,
              child: Column(
                children: [
                  Container(
                    height: 306,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                        bottomRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      color: AppTheme.white,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.gray,
                          ),
                        ),
                        SizedBox(height: 30),
                        SvgPicture.asset(
                          'assets/icons/alert.svg',
                          color: AppTheme.red,
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Invalid Email',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: AppTheme.black,
                          ),
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          child: Text(
                            'There is no email address like this, Please enter valid Email Address',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.72,
                              color: AppTheme.dark.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56,
                      margin: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'OK, Understood',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: AppTheme.fontFamily,
                            height: 1.5,
                            color: AppTheme.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
