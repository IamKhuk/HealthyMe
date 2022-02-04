import 'package:flutter/cupertino.dart';
import 'package:healthy_me/src/model/advice_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class AdviceContainer extends StatelessWidget {
  final AdviceModel data;

  AdviceContainer({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(11, 8),
            blurRadius: 19,
            spreadRadius: 0,
            color: AppTheme.gray,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 76,
            width: 76,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                data.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: AppTheme.fontFamily,
                    height: 1.5,
                    color: AppTheme.black,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  data.intro,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    fontFamily: AppTheme.fontFamily,
                    height: 1.5,
                    color: AppTheme.dark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 48,
            width: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppTheme.gray,
            ),
          )
        ],
      ),
    );
  }
}
