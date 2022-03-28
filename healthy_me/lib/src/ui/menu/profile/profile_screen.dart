import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/profile/personal_settings_screen.dart';
import 'package:healthy_me/src/ui/menu/profile/privacy_screen.dart';
import 'package:healthy_me/src/widgets/schedule_history.dart';
import 'package:healthy_me/src/widgets/settings_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/api/schedule_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _index = 0;
  String _myImage = '';
  String _myName = '';
  String _myEmail = '';
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    _getInfo();
    _getMoreData(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bg,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        imageUrl: _myImage,
                        placeholder: (context, url) => Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppTheme.gray,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppTheme.gray,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: AppTheme.purple,
                            ),
                          ),
                        ),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 16),
              Text(
                _myName,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: AppTheme.fontFamily,
                  height: 1.5,
                  color: AppTheme.black,
                ),
              ),
              Text(
                _myEmail,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  fontFamily: AppTheme.fontFamily,
                  height: 1.5,
                  color: AppTheme.dark,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 224),
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
                                        'Settings',
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
                                    blocSchedule.fetchSchedules('completed');
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
                                        'History',
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
                            ],
                          ),
                        ),
                        SizedBox(width: 36),
                      ],
                    ),
                    SizedBox(height: 24),
                    _index == 0
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              top: 12,
                              left: 36,
                              right: 36,
                              bottom: 24,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(48),
                                topRight: Radius.circular(48),
                              ),
                              color: AppTheme.purple,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 4,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppTheme.gray,
                                  ),
                                ),
                                SizedBox(height: 28),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PersonalSettingsScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: SettingsContainer(
                                    img: 'assets/icons/user.svg',
                                    title: 'Personal',
                                  ),
                                ),
                                SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return PrivacyScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: SettingsContainer(
                                    img: 'assets/icons/privacy.svg',
                                    title: 'Privacy & Security',
                                  ),
                                ),
                                SizedBox(height: 8),
                                SettingsContainer(
                                  img: 'assets/icons/promo.svg',
                                  title: 'Denote',
                                ),
                                SizedBox(height: 8),
                                SettingsContainer(
                                  img: 'assets/icons/help.svg',
                                  title: 'Help',
                                ),
                                SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    BottomDialog.showLogOut(context);
                                  },
                                  child: SettingsContainer(
                                    img: 'assets/icons/logout.svg',
                                    title: 'Logout',
                                  ),
                                ),
                                SizedBox(height: 92),
                              ],
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              top: 30,
                              left: 24,
                              right: 24,
                              bottom: 24,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(48),
                                topRight: Radius.circular(48),
                              ),
                              color: AppTheme.purple,
                            ),
                            child: StreamBuilder(
                              stream: blocSchedule.getSchedules,
                              builder: (context,
                                  AsyncSnapshot<ScheduleModel> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    padding: EdgeInsets.only(
                                      bottom: 68,
                                      top: 12,
                                    ),
                                    itemCount: snapshot.data!.schedule.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ScheduleHistory(
                                            data:
                                                snapshot.data!.schedule[index],
                                          ),
                                          index ==
                                                  snapshot.data!.schedule
                                                          .length -
                                                      1
                                              ? Container()
                                              : SizedBox(height: 12),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Shimmer.fromColors(
                                    child: ListView.builder(
                                      itemCount: 10,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(
                                        top: 12,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              height: 114,
                                              padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppTheme.baseColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: AppTheme
                                                              .baseColor,
                                                        ),
                                                      ),
                                                      SizedBox(width: 14),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 16,
                                                            width: 120,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: AppTheme
                                                                  .baseColor,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8),
                                                          Container(
                                                            height: 12,
                                                            width: 88,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: AppTheme
                                                                  .baseColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 12,
                                                        width: 12,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: AppTheme
                                                              .baseColor,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 12,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: AppTheme
                                                              .baseColor,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 12,
                                                        width: 12,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: AppTheme
                                                              .baseColor,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 12,
                                                        width: 72,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: AppTheme
                                                              .baseColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            index == 9
                                                ? Container()
                                                : SizedBox(height: 16),
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
                          ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _myImage = prefs.getString('avatar') ?? '';
      _myName = prefs.getString('fullname') ?? 'No nome';
      _myEmail = prefs.getString('email') ?? 'healthymeuser@gmail.com';
    });
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
