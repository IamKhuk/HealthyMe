import 'package:flutter/cupertino.dart';
import 'package:healthy_me/src/model/diseases_probability.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/utils/utils.dart';

class PercentageText extends StatelessWidget {
  final DiseaseProbability data;

  PercentageText({required this.data});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: Utils.percentageFormat(data.percentage)+'%',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: AppTheme.fontFamily,
          height: 1.5,
          color: AppTheme.red,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' - ' + data.disease.replaceAll('-', ' '),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: AppTheme.fontFamily,
              height: 1.5,
              color: AppTheme.black,
            ),
          ),
          TextSpan(
            text: '   '+data.text,
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
    );
  }
}
