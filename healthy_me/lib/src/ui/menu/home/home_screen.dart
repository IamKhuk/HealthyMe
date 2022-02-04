import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/defaults/doctors_list.dart';
import 'package:healthy_me/src/defaults/schedules_list.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/category_model.dart';
import 'package:healthy_me/src/model/doctor_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/doctor_details_screen.dart';
import 'package:healthy_me/src/ui/menu/home/doctors_screen.dart';
import 'package:healthy_me/src/ui/menu/profile/personal_settings_screen.dart';
import 'package:healthy_me/src/widgets/doctor_container.dart';
import 'package:healthy_me/src/widgets/visit_container.dart';

import '../../main_screen.dart';
import 'advices_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = new TextEditingController();
  bool onChanged = false;

  List<CategoryModel> categories = [
    CategoryModel(img: 'assets/icons/hospital_bed.svg', title: 'All'),
    CategoryModel(img: 'assets/icons/hospital_bed.svg', title: 'General'),
    CategoryModel(img: 'assets/icons/dentist.svg', title: 'Dentist'),
    CategoryModel(img: 'assets/icons/heart_beat.svg', title: 'Neurosurgeon'),
    CategoryModel(img: 'assets/icons/pill.svg', title: 'Pediatrics'),
    CategoryModel(img: 'assets/icons/needle.svg', title: 'Gynecologist'),
    CategoryModel(img: 'assets/icons/shield.svg', title: 'Other'),
  ];

  int ctgIndex = 0;

  List<DoctorModel> docs = [
    doc_01,
    doc_02,
    doc_03,
    doc_04,
    doc_05,
    doc_06,
    doc_07,
    doc_08,
    doc_09,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        leadingWidth: 76,
        leading: Row(
          children: [
            SizedBox(width: 36),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppTheme.gray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/menu.svg'),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Current location',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                fontFamily: AppTheme.fontFamily,
                height: 1.5,
                color: AppTheme.dark,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Samarkand City',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: AppTheme.fontFamily,
                height: 1.5,
                color: AppTheme.black,
              ),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.gray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/pfp.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 36),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 36),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width - 132,
                  padding: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: controller,
                    onChanged: (_text) {
                      setState(() {
                        onChanged = true;
                      });
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: AppTheme.fontFamily,
                      color: AppTheme.dark,
                    ),
                    autofocus: false,
                    cursorColor: AppTheme.purple,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search a doctor/ speciality',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        fontFamily: AppTheme.fontFamily,
                        color: AppTheme.dark,
                      ),
                      prefixIcon: onChanged == false &&
                              controller.text.length == 0
                          ? Container(
                              padding: EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                                left: 16,
                                right: 12,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/search.svg',
                                fit: BoxFit.contain,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller.text = '';
                                  if (controller.text == '') {
                                    onChanged = false;
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 12,
                                  bottom: 12,
                                  left: 16,
                                  right: 12,
                                ),
                                child: SvgPicture.asset('assets/icons/x.svg'),
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    BottomDialog.showDocFilter(context);
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.purple,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/icons/filter.svg'),
                    ),
                  ),
                ),
                SizedBox(width: 36),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 24),
                Expanded(
                  child: Text(
                    'Upcoming Schedule',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: 15, right: 24),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DoctorDetailsScreen(doc: schedules[0].doc);
                      },
                    ),
                  );
                },
                child: VisitContainer(
                    doc: schedules[0].doc,
                    time: [schedules[0].time[0], schedules[0].time[1]]),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AdvicesScreen();
                    },
                  ),
                );
              },
              child: Container(
                height: 64,
                margin: EdgeInsets.symmetric(horizontal: 36),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(11, 8),
                      blurRadius: 19,
                      spreadRadius: 0,
                      color: AppTheme.gray,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Get Healthcare Advices',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: AppTheme.orange,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 82,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 24),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        ctgIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              color: ctgIndex == index
                                  ? AppTheme.purple
                                  : AppTheme.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                ctgIndex == index
                                    ? BoxShadow(
                                        offset: Offset(5, 12),
                                        blurRadius: 19,
                                        spreadRadius: 0,
                                        color: AppTheme.gray,
                                      )
                                    : BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 0,
                                        spreadRadius: 0,
                                        color: AppTheme.gray,
                                      )
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                categories[index].img,
                                color: ctgIndex == index
                                    ? AppTheme.white
                                    : AppTheme.purple,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            categories[index].title,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 9,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 28),
            Row(
              children: [
                SizedBox(width: 24),
                Expanded(
                  child: Text(
                    'Find a Doctor',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DoctorsScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: 15, right: 24),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ListView.builder(
              itemCount: docs.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 24),
              itemBuilder: (context, index) {
                return categories[ctgIndex].title == 'All'
                    ? Column(
                        children: [
                          SizedBox(height: index == 0 ? 0 : 12),
                          DoctorContainer(doc: docs[index]),
                        ],
                      )
                    : categories[ctgIndex].title == 'Other' &&
                            docs[index].specialty != 'General' &&
                            docs[index].specialty != 'Dentist' &&
                            docs[index].specialty != 'Neurosurgeon' &&
                            docs[index].specialty != 'Pediatrics' &&
                            docs[index].specialty != 'Gynecologist'
                        ? Column(
                            children: [
                              SizedBox(height: index == 0 ? 0 : 12),
                              DoctorContainer(doc: docs[index]),
                            ],
                          )
                        : docs[index].specialty == categories[ctgIndex].title
                            ? Column(
                                children: [
                                  SizedBox(height: index == 0 ? 0 : 12),
                                  DoctorContainer(doc: docs[index]),
                                ],
                              )
                            : Container();
              },
            ),
            SizedBox(height: 92),
          ],
        ),
      ),
    );
  }
}
