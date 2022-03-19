import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/schedule_container.dart';

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
                                SizedBox(height: 12),

                              ],
                            )
                          : Container(),
                    ],
                  )
                : Container();
          } else {
            return Container();
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
