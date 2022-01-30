import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/defaults/me.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/profile/personal_settings_screen.dart';
import 'package:healthy_me/src/widgets/settings_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bg,
        brightness: Brightness.light,
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
                      child: Image.asset(
                        me.pfp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 16),
              Text(
                me.name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: AppTheme.fontFamily,
                  height: 1.5,
                  color: AppTheme.black,
                ),
              ),
              Text(
                me.email,
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
                    Container(
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
                          SettingsContainer(
                            img: 'assets/icons/privacy.svg',
                            title: 'Privacy & Security',
                          ),
                          SizedBox(height: 8),
                          SettingsContainer(
                            img: 'assets/icons/promo.svg',
                            title: 'Offers & Rewards',
                          ),
                          SizedBox(height: 8),
                          SettingsContainer(
                            img: 'assets/icons/help.svg',
                            title: 'Help',
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: (){
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
}
