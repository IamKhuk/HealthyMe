import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/model/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/doctor/doctor_details_screen.dart';
import 'package:healthy_me/src/ui/menu/schedule/appointment_screen.dart';
import 'package:healthy_me/src/utils/utils.dart';

class ScheduleContainer extends StatefulWidget {
  final ScheduleModel data;
  final Function(bool cancel) onChanged;

  ScheduleContainer({
    required this.data,
    required this.onChanged,
  });

  @override
  _ScheduleContainerState createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return DoctorDetailsScreen(doc: widget.data.doc);
              //     },
              //   ),
              // );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      widget.data.doc.pfp,
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
                        'Dr. ' + widget.data.doc.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: AppTheme.fontFamily,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.data.doc.specialty,
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
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/schedule.svg',
                      color: AppTheme.purple,
                      height: 16,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        Utils.scheduleDateFormat(
                          widget.data.time[0],
                          widget.data.time[1],
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          fontFamily: AppTheme.fontFamily,
                          height: 1.5,
                          color: AppTheme.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/time.svg',
                    color: AppTheme.purple,
                    height: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    Utils.scheduleHourFormat(
                      widget.data.time[0],
                      widget.data.time[1],
                    ),
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
          SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.data.time[1].compareTo(DateTime.now()) >= 0 &&
                      widget.data.canceled == false) {
                    widget.onChanged(true);
                  }
                },
                child: Container(
                  height: 38,
                  width: (MediaQuery.of(context).size.width - 116) / 2,
                  decoration: BoxDecoration(
                    color: AppTheme.gray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      widget.data.canceled == true
                          ? 'Canceled'
                          : widget.data.time[1].compareTo(DateTime.now()) < 0
                              ? 'Completed'
                              : 'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        fontFamily: AppTheme.fontFamily,
                        height: 1.5,
                        color: AppTheme.purple,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AppointmentScreen();
                      },
                    ),
                  );
                },
                child: Container(
                  height: 38,
                  width: (MediaQuery.of(context).size.width - 116) / 2,
                  decoration: BoxDecoration(
                    color: AppTheme.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Reschedule',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        fontFamily: AppTheme.fontFamily,
                        height: 1.5,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
