import 'package:flutter/cupertino.dart';
import 'package:healthy_me/src/model/drugs_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class DrugsContainer extends StatelessWidget {
  final DrugsModel data;

  DrugsContainer({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.only(top: 48, right: 24, left: 24, bottom: 16,),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 16,
                    color: AppTheme.black,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    data.img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 44),
            ],
          ),
        ],
      ),
    );
  }
}
