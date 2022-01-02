import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/model/doctor_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class VisitContainer extends StatefulWidget {
  final DoctorModel doc;
  final List<DateTime> time;

  VisitContainer({
    required this.doc,
    required this.time,
  });

  @override
  _VisitContainerState createState() => _VisitContainerState();
}

class _VisitContainerState extends State<VisitContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.purple,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.doc.pfp,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doc.name,
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
                      widget.doc.specialty,
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
              ],
            ),
          ),
          Container(
            height: 56,
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.purpleLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/time.svg', color: AppTheme.white,),
                SizedBox(width: 14),
                Text(
                  widget.time[0].weekday.toString() +
                      ', ' +
                      widget.time[0].month.toString() +
                      ', ' +
                      widget.time[0].year.toString() +
                      ', ' +
                      widget.time[0].hour.toString() +
                      ' AM - ' +
                      widget.time[1].hour.toString() +
                      ' AM',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    fontFamily: AppTheme.fontFamily,
                    height: 1.5,
                    color: AppTheme.white,
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
