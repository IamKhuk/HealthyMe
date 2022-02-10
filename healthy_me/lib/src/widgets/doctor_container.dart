import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/model/doctor_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/doctor/doctor_details_screen.dart';
import 'package:healthy_me/src/widgets/rating_container.dart';

class DoctorContainer extends StatelessWidget {
  final DoctorModel doc;

  DoctorContainer({required this.doc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DoctorDetailsScreen(doc: doc);
            },
          ),
        );
      },
      child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ' + doc.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: AppTheme.fontFamily,
                      height: 1.5,
                      color: AppTheme.dark,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    doc.specialty,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      fontFamily: AppTheme.fontFamily,
                      height: 1.5,
                      color: AppTheme.dark,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      RatingContainer(rating: doc.star),
                      SizedBox(width: 8),
                      Text(
                        '(' + doc.reviews.toString() + ' reviews)',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          fontFamily: AppTheme.fontFamily,
                          height: 1.5,
                          color: AppTheme.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/icons/right.svg',
              color: AppTheme.purple,
              height: 20,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
