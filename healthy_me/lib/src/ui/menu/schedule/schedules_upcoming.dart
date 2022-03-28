import 'package:flutter/material.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/model/api/schedule_result_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
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
  bool onLoading = false;

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
      body: Stack(
        children: [
          StreamBuilder(
            stream: blocSchedule.getSchedules,
            builder: (context, AsyncSnapshot<ScheduleModel> snapshot) {
              if (snapshot.hasData) {
                snapshot.data!.schedule
                    .sort((a, b) => a.startDatetime.compareTo(b.startDatetime));
                List<Schedule> _list = snapshot.data!.schedule
                    .where((element) =>
                        element.startDatetime.isAfter(DateTime.now()) == true)
                    .toList();
                return _list.length > 0
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
                            data: _list[0],
                            onChanged: (_cancel) async {
                              if (_cancel == true) {
                                setState(() {
                                  onLoading = true;
                                });
                                var response = await Repository()
                                    .fetchScheduleCancel(
                                    _list[0].id);
                                if (response.isSuccess) {
                                  setState(() {
                                    onLoading = false;
                                  });
                                  if (response.isSuccess) {
                                    setState(() {
                                      onLoading = false;
                                    });
                                    var result = ScheduleResultModel.fromJson(
                                        response.result);
                                    if (result.status == 1) {
                                      blocSchedule.fetchSchedules(
                                        'upcoming',
                                      );
                                      BottomDialog.showAction(
                                        context,
                                        'Successfully Deleted',
                                        'Selected Schedule canceled',
                                        'assets/icons/success.svg',
                                      );
                                    } else {
                                      BottomDialog.showAction(
                                        context,
                                        'Something went wrong',
                                        'Please try again after some time',
                                        'assets/icons/alert.svg',
                                      );
                                    }
                                  } else {
                                    setState(() {
                                      onLoading = false;
                                    });
                                    if (response.status == -1) {
                                      BottomDialog.showAction(
                                        context,
                                        'Connection Failed',
                                        'You do not have internet connection, please try again',
                                        'assets/icons/alert.svg',
                                      );
                                    } else {
                                      BottomDialog.showAction(
                                        context,
                                        'Server error',
                                        'Something went wrong, Please try again after some time',
                                        'assets/icons/alert.svg',
                                      );
                                    }
                                  }
                                }
                              }
                            },
                            canceled: false,
                          ),
                          SizedBox(height: 24),
                          _list.length > 1
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
                                      itemCount:
                                      _list.length - 1,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(bottom: 96),
                                      itemBuilder: (context, index) {
                                        List<Schedule> _schedules = [];
                                        _schedules.insertAll(
                                          0,
                                          _list.getRange(1,
                                              _list.length),
                                        );
                                        return Column(
                                          children: [
                                            ScheduleContainer(
                                              data: _schedules[index],
                                              canceled: false,
                                              onChanged: (_cancel) async {
                                                if (_cancel == true) {
                                                  setState(() {
                                                    onLoading = true;
                                                  });
                                                  var response =
                                                      await Repository()
                                                          .fetchScheduleCancel(
                                                              _schedules[index]
                                                                  .id);
                                                  if (response.isSuccess) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    if (response.isSuccess) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      var result =
                                                          ScheduleResultModel
                                                              .fromJson(response
                                                                  .result);
                                                      if (result.status == 1) {
                                                        blocSchedule
                                                            .fetchSchedules(
                                                          'upcoming',
                                                        );
                                                        BottomDialog.showAction(
                                                          context,
                                                          'Successfully Deleted',
                                                          'Selected Schedule canceled',
                                                          'assets/icons/success.svg',
                                                        );
                                                      } else {
                                                        BottomDialog.showAction(
                                                          context,
                                                          'Something went wrong',
                                                          'Please try again after some time',
                                                          'assets/icons/alert.svg',
                                                        );
                                                      }
                                                    } else {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      if (response.status ==
                                                          -1) {
                                                        BottomDialog.showAction(
                                                          context,
                                                          'Connection Failed',
                                                          'You do not have internet connection, please try again',
                                                          'assets/icons/alert.svg',
                                                        );
                                                      } else {
                                                        BottomDialog.showAction(
                                                          context,
                                                          'Server error',
                                                          'Something went wrong, Please try again after some time',
                                                          'assets/icons/alert.svg',
                                                        );
                                                      }
                                                    }
                                                  }
                                                }
                                              },
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
                    : Center(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'There is no upcoming appointments',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 14,
                              height: 1.5,
                              color: AppTheme.black,
                            ),
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
                              border: Border.all(
                                  color: AppTheme.baseColor, width: 2),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppTheme.baseColor,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          height: 12,
                                          width: 88,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppTheme.baseColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 38,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  116) /
                                              2,
                                      decoration: BoxDecoration(
                                        color: AppTheme.baseColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Container(
                                      height: 38,
                                      width:
                                          (MediaQuery.of(context).size.width -
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
          onLoading == true
              ? Container(
                  color: AppTheme.black.withOpacity(0.45),
                  child: Center(
                    child: Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 25,
                            spreadRadius: 0,
                            color: AppTheme.dark.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppTheme.purple),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
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
