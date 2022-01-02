import 'package:flutter/cupertino.dart';
import 'package:healthy_me/src/model/doctor_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class DoctorContainer extends StatelessWidget {
  final DoctorModel doc;

  DoctorContainer({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                doc.pfp,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(

            ),
          ),
        ],
      ),
    );
  }
}
