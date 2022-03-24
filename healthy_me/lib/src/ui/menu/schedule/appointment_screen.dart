import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/dialog/center_dialog.dart';
import 'package:healthy_me/src/model/visit_date_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/utils/utils.dart';

class AppointmentScreen extends StatefulWidget {
  final int doctorId;
  final int professionId;

  AppointmentScreen({
    required this.doctorId,
    required this.professionId,
  });

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  List<VisitDateModel> dateList = Utils.visitDateFormat(DateTime.now());
  int _selectedDate = 0;
  int _selectedTime = 0;
  int _selectedDay = 0;

  // int _selectedWeek = 0;
  int _selectedMonth = 0;
  int _selectedYear = 0;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  TextEditingController _controller = new TextEditingController();
  bool _loading = false;
  late DateTime time;

  @override
  void initState() {
    _selectedYear = DateTime.now().year;
    _selectedMonth = DateTime.now().month;
    _selectedDay = DateTime.now().day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          'Make an Appointment',
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
                  _scaffoldKey.currentState!.openEndDrawer();
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
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Container(
        color: AppTheme.white,
        width: MediaQuery.of(context).size.width - 36,
        child: Drawer(
          elevation: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView(
                padding: EdgeInsets.all(24),
                children: [
                  SizedBox(height: 24),
                  Text(
                    'What can I do in this page?',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You can mainly make an appointment with certain doctor you selected, for doing so, you need to complete few process. Firstly, you need to select an appropriate date and time for the appointment, you can leave a request (optional) too, and after that simply tap the \'Make appointment\' button, then the appointment will be scheduled and added to your Schedule List.',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.8,
                            color: AppTheme.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'How to select date?',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.bg,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 9),
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: AppTheme.gray,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SvgPicture.asset('assets/images/select_date.svg'),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You can select the date by choosing one of the dates from the list like above, chosen date will be appeared as an orange one.',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.8,
                            color: AppTheme.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'How to select time?',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.bg,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 9),
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: AppTheme.gray,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SvgPicture.asset('assets/images/select_time.svg'),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Here is the example of the list of available times to make an appointment. Just simply choose one of them, the chosen one will get orange.',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.8,
                            color: AppTheme.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Note: Selecting date and time are required, so that means that you have to select them. Otherwise, you will not be able to make an appointment. But writing a request is optional so you decide whether you write or not',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            height: 1.8,
                            color: AppTheme.orange,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'How to select time?',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.purple,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 9),
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: AppTheme.gray,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Make Appointment',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: AppTheme.fontFamily,
                          height: 1.5,
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You can schedule an appointment by tapping this button, but make sure you selected the date and time, you will not be able to schedule unless you select them both.',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.8,
                            color: AppTheme.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 90),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 61,
                      width: 61,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5, 9),
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: AppTheme.gray,
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/x.svg',
                          color: AppTheme.purple,
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView(
              padding: EdgeInsets.only(bottom: 90),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 36),
                    Text(
                      'Select Date',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  height: 84,
                  child: ListView.builder(
                    itemCount: dateList.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 36),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = index;
                            _selectedDay = dateList[index].day;
                            // _selectedWeek = dateList[index].week;
                            _selectedMonth = dateList[index].month;
                            _selectedYear = dateList[index].year;
                          });
                        },
                        child: Container(
                          height: 84,
                          margin: EdgeInsets.only(
                            right: index == dateList.length - 1 ? 36 : 16,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 64,
                                width: 64,
                                padding: EdgeInsets.only(
                                  top: 11,
                                  bottom: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedDate == index
                                      ? AppTheme.orange
                                      : AppTheme.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          dateList[index].day.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            fontFamily: AppTheme.fontFamily,
                                            height: 1.5,
                                            color: _selectedDate == index
                                                ? AppTheme.white
                                                : AppTheme.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          Utils.monthFormat(
                                              dateList[index].month),
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            fontFamily: AppTheme.fontFamily,
                                            color: _selectedDate == index
                                                ? AppTheme.white
                                                : AppTheme.dark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                Utils.weekFormat(dateList[index].week),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 9,
                                  fontFamily: AppTheme.fontFamily,
                                  height: 1.5,
                                  color: AppTheme.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 36),
                    Text(
                      'Select Time',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 92,
                    childAspectRatio: 23 / 11,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: Utils.visitTimeFormat().length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        if (Utils.visitTimeFormat()[index].free == false) {
                          CenterDialog.showVisitErrorDialog(context);
                        }
                        if (Utils.visitTimeFormat()[index].free == true) {
                          setState(() {
                            _selectedTime = index;
                            _selectedHour = Utils.visitTimeFormat()[index].hour;
                            _selectedMinute =
                                Utils.visitTimeFormat()[index].minutes;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTime == index
                              ? AppTheme.orange
                              : AppTheme.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          Utils.visitTimeFormat()[index].hour.toString() +
                              ':' +
                              Utils.minuteFormat(
                                  Utils.visitTimeFormat()[index].minutes),
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            height: 1.5,
                            color: _selectedTime == index
                                ? AppTheme.white
                                : AppTheme.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 36),
                    Text(
                      'Your Request',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 36),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    enabled: true,
                    maxLines: 8,
                    controller: _controller,
                    enableSuggestions: true,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: AppTheme.purple,
                    enableInteractiveSelection: true,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.72,
                      color: AppTheme.dark,
                    ),
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a message...',
                      hintStyle: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        height: 1.72,
                        color: AppTheme.dark.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  left: 36,
                  right: 36,
                  bottom: 24,
                ),
                child: GestureDetector(
                  onTap: () async {
                    time = DateTime(
                      _selectedYear,
                      _selectedMonth,
                      _selectedDay,
                      _selectedHour,
                      _selectedMinute,
                    );
                    setState(() {
                      _loading = true;
                    });

                    var response = await Repository().fetchScheduleSend(
                      widget.doctorId,
                      time,
                      _controller.text,
                      widget.professionId,
                    );
                    if (response.isSuccess) {
                      setState(() {
                        _loading = false;
                      });
                      int status = response.result["status"] ?? 0;
                      if (status == 1) {
                        Navigator.pop(context);
                      } else {
                        BottomDialog.showAction(
                          context,
                          'Cannot Create Schedule',
                          response.result["msg"] ??
                              "Something went wrong, Please try again",
                          'assets/icons/alert.svg',
                        );
                      }
                    } else if (response.status == -1) {
                      setState(() {
                        _loading = false;
                      });
                      BottomDialog.showAction(
                        context,
                        'Connection Failed',
                        "You do not have internet connection, please try again",
                        'assets/icons/alert.svg',
                      );
                    } else {
                      setState(() {
                        _loading = false;
                      });
                      BottomDialog.showAction(
                        context,
                        'Something went wrong',
                        response.result["msg"] ??
                            "Cannot connect to server, Please try again",
                        'assets/icons/alert.svg',
                      );
                    }
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.purple,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 9),
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: AppTheme.gray,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Make Appointment',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: AppTheme.fontFamily,
                          height: 1.5,
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          _loading == true
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
}
