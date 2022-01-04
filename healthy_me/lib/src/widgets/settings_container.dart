import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class SettingsContainer extends StatelessWidget {
  final String img;
  final String title;

  SettingsContainer({
    required this.img,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: AppTheme.gray.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                img,
                color: AppTheme.white,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                height: 1.5,
                color: AppTheme.white,
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/right.svg',
            color: AppTheme.white,
          ),
        ],
      ),
    );
  }
}
