import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/schedule_container.dart';

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
            return snapshot.data!.schedule.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data!.schedule.length,
                    physics: NeverScrollableScrollPhysics(),
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
        'completed',
      );
      page++;
    }
  }
}
