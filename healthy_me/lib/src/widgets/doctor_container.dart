import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/model/api/doctors_list_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/doctor/doctor_details_screen.dart';
import 'package:healthy_me/src/widgets/rating_container.dart';

class DoctorContainer extends StatelessWidget {
  final DocListResult doc;

  DoctorContainer({required this.doc});

  bool isLoadingImage = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DoctorDetailsScreen(id: doc.id);
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
                child: isLoadingImage
                    ? Container(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppTheme.purple),
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: doc.avatar,
                        placeholder: (context, url) => Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.gray,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.gray,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: AppTheme.purple,
                            ),
                          ),
                        ),
                        height: 60,
                        width: 60,
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
                    'Dr. ' + doc.fullName,
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
                    doc.profession.name,
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
                      RatingContainer(rating: doc.reviewAvg),
                      SizedBox(width: 8),
                      Text(
                        '(' + doc.reviewCount.toString() + ' reviews)',
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
