import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/schedule_container.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingSchedules extends StatefulWidget {
  @override
  _UpcomingSchedulesState createState() => _UpcomingSchedulesState();
}

class _UpcomingSchedulesState extends State<UpcomingSchedules> {
  ScrollController _sc = new ScrollController();
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    page = 1;
    _getMoreData(page);
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: StreamBuilder(
        stream: blocSchedule.getSchedules,
        builder: (context, AsyncSnapshot<ScheduleModel> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.schedule.length > 0
                ? ListView(
                    padding: EdgeInsets.only(
                      top: 76,
                      bottom: 24,
                      left: 36,
                      right: 36,
                    ),
                    children: [
                      Text(
                        'Nearest Visit',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      ScheduleContainer(
                        data: snapshot.data!.schedule[0],
                        onChanged: (_cancel) {},
                        canceled: false,
                      ),
                      SizedBox(height: 24),
                      snapshot.data!.schedule.length > 1
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Future Visits',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppTheme.fontFamily,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                ListView.builder(
                                  itemCount: snapshot.data!.schedule.length - 1,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 96),
                                  itemBuilder: (context, index) {
                                    List<Schedule> _schedules = [];
                                    _schedules.insertAll(
                                      0,
                                      snapshot.data!.schedule.getRange(
                                          1, snapshot.data!.schedule.length),
                                    );
                                    return Column(
                                      children: [
                                        ScheduleContainer(
                                          data: _schedules[index],
                                          canceled: false,
                                          onChanged: (_cancel) {},
                                        ),
                                        index == _schedules.length - 1
                                            ? Container()
                                            : SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  )
                : Container();
          } else {
            return Shimmer.fromColors(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(
                  bottom: 96,
                  top: 76,
                  left: 36,
                  right: 36,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 168,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: AppTheme.baseColor, width: 2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppTheme.baseColor,
                                  ),
                                ),
                                SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 16,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppTheme.baseColor,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 12,
                                      width: 88,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppTheme.baseColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppTheme.baseColor,
                                  ),
                                ),
                                Container(
                                  height: 12,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppTheme.baseColor,
                                  ),
                                ),
                                Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppTheme.baseColor,
                                  ),
                                ),
                                Container(
                                  height: 12,
                                  width: 72,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppTheme.baseColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 38,
                                  width: (MediaQuery.of(context).size.width -
                                      116) /
                                      2,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Container(
                                  height: 38,
                                  width: (MediaQuery.of(context).size.width -
                                      116) /
                                      2,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      index == 9 ? Container() : SizedBox(height: 16),
                    ],
                  );
                },
              ),
              baseColor: AppTheme.baseColor,
              highlightColor: AppTheme.highlightColor,
            );
          }
        },
      ),
    );
  }

  void _getMoreData(int index) async {
    if (!isLoading) {
      blocSchedule.fetchSchedules(
        'upcoming',
      );
      page++;
    }
  }
}
