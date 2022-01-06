import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/defaults/schedules_list.dart';
import 'package:healthy_me/src/model/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/schedule_container.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late List<ScheduleModel> canceled;
  late List<ScheduleModel> completed;
  int _index = 0;
  late List<ScheduleModel> list;

  @override
  void initState() {
    schedules.removeAt(0);
    list = schedules
        .where((element) =>
            element.canceled == false &&
            element.completed == false &&
            element.time[0].day > DateTime.now().day)
        .toList();
    canceled = schedules.where((element) => element.canceled == true).toList();
    completed = schedules
        .where((element) => element.time[0].day < DateTime.now().day)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bg,
        brightness: Brightness.light,
        title: Text(
          'Schedule',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: list.length > 0
                    ? ListView(
                        padding: EdgeInsets.only(
                          left: 36,
                          right: 36,
                          top: 76,
                          bottom: 12,
                        ),
                        children: [
                          _index == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nearest Visit',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    ScheduleContainer(
                                      data: schedules.firstWhere(
                                        (element) =>
                                            element.time[0].day >
                                                DateTime.now().day &&
                                            element.canceled == false,
                                      ),
                                      onChanged: (cancel) {
                                        setState(() {
                                          list[0].canceled = cancel;
                                          if (list[0].canceled == true) {
                                            canceled.add(list[0]);
                                            list.removeAt(0);
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(height: 24),
                                    Text(
                                      'Future Visits',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          ListView.builder(
                            itemCount: _index == 0
                                ? list.length
                                : _index == 1
                                    ? completed.length
                                    : canceled.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _index == 0
                                  ? Column(
                                      children: [
                                        SizedBox(height: 16),
                                        ScheduleContainer(
                                          data: list[index],
                                          onChanged: (cancel) {
                                            setState(() {
                                              list[index].canceled = true;
                                              if (list[index].canceled ==
                                                  true) {
                                                canceled.add(list[index]);
                                                list.removeAt(index);
                                              }
                                            });
                                          },
                                        ),
                                        index == list.length - 1
                                            ? SizedBox(height: 88)
                                            : Container(),
                                      ],
                                    )
                                  : _index == 1
                                      ? Column(
                                          children: [
                                            SizedBox(height: 16),
                                            ScheduleContainer(
                                              data: completed[index],
                                              onChanged: (cancel) {},
                                            ),
                                            index == completed.length - 1
                                                ? SizedBox(height: 88)
                                                : Container(),
                                          ],
                                        )
                                      : _index == 2
                                          ? Column(
                                              children: [
                                                SizedBox(height: 16),
                                                ScheduleContainer(
                                                  data: canceled[index],
                                                  onChanged: (cancel) {},
                                                ),
                                                index == canceled.length - 1
                                                    ? SizedBox(height: 88)
                                                    : Container(),
                                              ],
                                            )
                                          : Container();
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: Text('There is no visits'),
                      ),
              ),
              SizedBox(height: 1),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 36),
                  Container(
                    height: 44,
                    width: MediaQuery.of(context).size.width - 72,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5, 9),
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: AppTheme.gray.withOpacity(0.6),
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 0;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 130),
                              decoration: BoxDecoration(
                                color: _index == 0
                                    ? AppTheme.orange
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Upcoming',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: _index == 0
                                        ? AppTheme.white
                                        : AppTheme.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 1;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 130),
                              decoration: BoxDecoration(
                                color: _index == 1
                                    ? AppTheme.orange
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: _index == 1
                                        ? AppTheme.white
                                        : AppTheme.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _index = 2;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 130),
                              decoration: BoxDecoration(
                                color: _index == 2
                                    ? AppTheme.orange
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Canceled',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: _index == 2
                                        ? AppTheme.white
                                        : AppTheme.dark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 36),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
