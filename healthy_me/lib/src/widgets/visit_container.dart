import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/utils/utils.dart';

class VisitContainer extends StatefulWidget {
  final Schedule data;

  VisitContainer({
    required this.data,
  });

  @override
  _VisitContainerState createState() => _VisitContainerState();
}

class _VisitContainerState extends State<VisitContainer> {
  late DateTime second;

  @override
  void initState() {
    int year = widget.data.startDatetime.year;
    int month = widget.data.startDatetime.month;
    int day = widget.data.startDatetime.day;
    int hour = widget.data.startDatetime.hour;
    int min = widget.data.startDatetime.minute;

    second = DateTime(year, month, day, hour, min + 30);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.purple,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: widget.data.doctor.avatar,
                    placeholder: (context, url) => Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.gray,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 50,
                      width: 50,
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
                    height: 50,
                    width: 50,
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
                      'Dr. '+ widget.data.doctor.fullName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: AppTheme.fontFamily,
                        height: 1.5,
                        color: AppTheme.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.data.profession.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        fontFamily: AppTheme.fontFamily,
                        height: 1.5,
                        color: AppTheme.light,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.purpleLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/time.svg', color: AppTheme.white,),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    Utils.dateFormat(widget.data.startDatetime, second),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      fontFamily: AppTheme.fontFamily,
                      height: 1.5,
                      color: AppTheme.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
