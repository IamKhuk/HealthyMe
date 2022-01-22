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
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(36),
                  topLeft: Radius.circular(36),
                ),
                color: AppTheme.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              margin: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 32,
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
                  GestureDetector(
                    onTap: () {
                      delete(true);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppTheme.purple,
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
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
