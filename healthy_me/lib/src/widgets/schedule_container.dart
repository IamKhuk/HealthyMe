import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/doctor/doctor_details_screen.dart';
import 'package:healthy_me/src/ui/menu/schedule/appointment_screen.dart';
import 'package:healthy_me/src/utils/utils.dart';

class ScheduleContainer extends StatefulWidget {
  final Schedule data;
  final bool canceled;
  final Function(bool cancel) onChanged;

  ScheduleContainer({
    required this.data,
    required this.canceled,
    required this.onChanged,
  });

  @override
  _ScheduleContainerState createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  bool isLoadingImage = false;
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DoctorDetailsScreen(id: widget.data.doctor.id);
                  },
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: isLoadingImage
                        ? Container(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.purple),
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.data.doctor.avatar,
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
                        'Dr. ' + widget.data.doctor.fullName,
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
                        widget.data.profession.name,
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
                          widget.data.startDatetime,
                          second,
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
                      widget.data.startDatetime,
                      second,
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
              widget.canceled == false
                  ? GestureDetector(
                      onTap: () {
                        if (widget.data.startDatetime
                                .compareTo(DateTime.now()) >=
                            0) {
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
                            widget.data.startDatetime
                                        .compareTo(DateTime.now()) <
                                    0
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
                    )
                  : Container(
                      height: 38,
                      width: (MediaQuery.of(context).size.width - 116) / 2,
                      decoration: BoxDecoration(
                        color: AppTheme.gray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Canceled',
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
              SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AppointmentScreen(
                          professionId: widget.data.profession.id,
                          doctorId: widget.data.doctor.id,
                        );
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
