import 'package:flutter/material.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/schedule_container.dart';
import 'package:shimmer/shimmer.dart';

class CompletedSchedules extends StatefulWidget {
  @override
  _CompletedSchedulesState createState() => _CompletedSchedulesState();
}

class _CompletedSchedulesState extends State<CompletedSchedules> {
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
            snapshot.data!.schedule
                .sort((a, b) => a.startDatetime.compareTo(b.startDatetime));
            return snapshot.data!.schedule.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data!.schedule.length,
                    padding: EdgeInsets.only(
                      bottom: 96,
                      top: 76,
                      left: 36,
                      right: 36,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ScheduleContainer(
                            data: snapshot.data!.schedule[index],
                            canceled: false,
                            onChanged: (_cancel) {},
                          ),
                          index == snapshot.data!.schedule.length - 1
                              ? Container()
                              : SizedBox(height: 16),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 24,
                        right: 24,
                        bottom: 16,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 36),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'There is no completed appointments',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 14,
                                height: 1.5,
                                color: AppTheme.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
        'completed',
      );
      page++;
    }
  }
}
