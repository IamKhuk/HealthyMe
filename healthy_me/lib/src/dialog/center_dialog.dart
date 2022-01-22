import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class CenterDialog {
  static void showVisitErrorDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'Oops',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.red,
            ),
          ),
          content: Text(
            'Sorry, appointment is not available at this time',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 16,
              color: AppTheme.black,
            ),
          ),
          actions: [
            GestureDetector(
              child: Container(
                color: Colors.transparent,
                height: 44,
                child: Center(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5,
                      decoration: TextDecoration.none,
                      color: AppTheme.purpleLight,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
