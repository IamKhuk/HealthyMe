import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/schedule_container.dart';
import 'package:shimmer/shimmer.dart';

class SchedulesUpcoming extends StatefulWidget {
  @override
  _SchedulesUpcomingState createState() => _SchedulesUpcomingState();
}

class _SchedulesUpcomingState extends State<SchedulesUpcoming> {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        leadingWidth: 76,
        leading: Row(
          children: [
            SizedBox(width: 36),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppTheme.gray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/left.svg'),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: Text(
          'Upcoming Schedules',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // _scaffoldKey.currentState!.openEndDrawer();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: AppTheme.gray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset('assets/icons/help.svg'),
                ),
              ),
            ],
          ),
          SizedBox(width: 36),
        ],
      ),
      body: StreamBuilder(
        stream: blocSchedule.getSchedules,
        builder: (context, AsyncSnapshot<ScheduleModel> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.schedule.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data!.schedule.length,
                    padding: EdgeInsets.only(
                      bottom: 24,
                      top: 20,
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
                : Container();
          } else {
            return Shimmer.fromColors(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(
                  bottom: 24,
                  top: 20,
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
