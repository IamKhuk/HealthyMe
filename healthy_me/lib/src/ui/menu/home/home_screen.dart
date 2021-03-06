import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/bloc/home_bloc.dart';
import 'package:healthy_me/src/bloc/profile_bloc.dart';
import 'package:healthy_me/src/bloc/schedule_bloc.dart';
import 'package:healthy_me/src/defaults/categories_list.dart';
import 'package:healthy_me/src/model/api/doctors_list_model.dart';
import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/doctor/doctors_screen.dart';
import 'package:healthy_me/src/ui/menu/profile/personal_settings_screen.dart';
import 'package:healthy_me/src/ui/menu/schedule/upcoming_schedules.dart';
import 'package:healthy_me/src/widgets/doctor_container.dart';
import 'package:healthy_me/src/widgets/drawer/home_drawer.dart';
import 'package:healthy_me/src/widgets/visit_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'advices/advices_screen.dart';
import 'doctor/doctor_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  TextEditingController controller = new TextEditingController();
  ScrollController _sc = new ScrollController();
  bool onChanged = false;
  String search = '';
  int professionId = -1;
  int regionId = -1;
  int cityId = -1;
  bool isLoading = false;
  int page = 1;
  int ctgIndex = 0;
  String _myImage = '';
  String _cityName = '';
  String _myName = '';
  String _myEmail = '';

  @override
  void initState() {
    page = 1;
    blocProfile.fetchMe();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.minScrollExtent) {
        _getData();
      }
    });
    blocProfile.getInfo.listen((event) {
      setState(() {
        _myImage = event.avatar;
      });
      print('MY IMAGE: ' + _myImage);
    });
    blocProfile.fetchMeCache();
    blocSchedule.fetchSchedules(
      'upcoming',
    );
    _getMoreData(page);
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
    _getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 76,
        leading: Row(
          children: [
            SizedBox(width: 36),
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
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
              _cityName == '' ? 'Could not find' : _cityName,
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
                    child: CachedNetworkImage(
                      imageUrl: _myImage,
                      placeholder: (context, url) => Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppTheme.gray,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppTheme.gray,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: AppTheme.purple,
                          ),
                        ),
                      ),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 36),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      drawer: HomeDrawer(name: _myName, email: _myEmail, img: _myImage),
      drawerEnableOpenDragGesture: false,
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
                Stack(
                  children: [
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
                                    child:
                                        SvgPicture.asset('assets/icons/x.svg'),
                                  ),
                                ),
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
                        height: 48,
                        width: MediaQuery.of(context).size.width - 132,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12),
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
            StreamBuilder(
              stream: blocSchedule.getSchedules,
              builder: (context, AsyncSnapshot<ScheduleModel> snapshot) {
                _sc.addListener(() {
                  if (_sc.position.pixels == _sc.position.minScrollExtent) {
                    _getData();
                  }
                });
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SchedulesUpcoming();
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DoctorDetailsScreen(
                                    id: snapshot.data!.schedule[0].doctor.id,
                                  );
                                },
                              ),
                            );
                          },
                          child: VisitContainer(
                            data: snapshot.data!.schedule[0],
                          ),
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
                            return Row(
                              children: [
                                GestureDetector(
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
                                            borderRadius:
                                                BorderRadius.circular(16),
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
                                ),
                                index == categories.length - 1
                                    ? SizedBox(width: 8)
                                    : Container(),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 28),
                    ],
                  );
                } else {
                  return Shimmer.fromColors(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 24),
                            Container(
                              height: 22,
                              width: 180,
                              decoration: BoxDecoration(
                                color: AppTheme.baseColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                              height: 14,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.baseColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(width: 24),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 162,
                          width: MediaQuery.of(context).size.width - 48,
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          padding: EdgeInsets.only(
                            top: 24,
                            left: 12,
                            right: 12,
                            bottom: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.baseColor,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 8),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: AppTheme.baseColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 112,
                                        decoration: BoxDecoration(
                                          color: AppTheme.baseColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 14,
                                        width: 92,
                                        decoration: BoxDecoration(
                                          color: AppTheme.baseColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 56,
                                width: MediaQuery.of(context).size.width - 72,
                                margin: EdgeInsets.symmetric(horizontal: 36),
                                decoration: BoxDecoration(
                                  color: AppTheme.baseColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 64,
                          width: MediaQuery.of(context).size.width - 48,
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.baseColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Container(
                              height: 16,
                              width: 200,
                              decoration: BoxDecoration(
                                color: AppTheme.baseColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 64,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 64,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 64,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 64,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  height: 12,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: AppTheme.baseColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 28),
                      ],
                    ),
                    baseColor: AppTheme.baseColor,
                    highlightColor: AppTheme.highlightColor,
                  );
                }
              },
            ),
            StreamBuilder(
              stream: blocHome.getDocs,
              builder: (context, AsyncSnapshot<DoctorsListModel> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
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
                        itemCount: snapshot.data!.results.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        itemBuilder: (context, index) {
                          return categories[ctgIndex].title == 'All'
                              ? Column(
                                  children: [
                                    SizedBox(height: index == 0 ? 0 : 12),
                                    DoctorContainer(
                                        doc: snapshot.data!.results[index]),
                                  ],
                                )
                              : categories[ctgIndex].idList.contains(snapshot
                                      .data!.results[index].profession.id)
                                  ? Column(
                                      children: [
                                        SizedBox(height: index == 0 ? 0 : 12),
                                        DoctorContainer(
                                            doc: snapshot.data!.results[index]),
                                      ],
                                    )
                                  : Container();
                        },
                      ),
                    ],
                  );
                } else {
                  return Shimmer.fromColors(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 24),
                            Container(
                              height: 22,
                              width: 180,
                              decoration: BoxDecoration(
                                color: AppTheme.baseColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                              height: 14,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.baseColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(width: 24),
                          ],
                        ),
                        SizedBox(height: 12),
                        ListView.builder(
                          itemCount: 10,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                            bottom: 96,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 80,
                                  padding: EdgeInsets.only(
                                    left: 12,
                                    top: 10,
                                    bottom: 10,
                                    right: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: AppTheme.baseColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: AppTheme.baseColor,
                                        ),
                                      ),
                                      SizedBox(width: 14),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 14,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: AppTheme.baseColor,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            height: 10,
                                            width: 88,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: AppTheme.baseColor,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 8,
                                                width: 56,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: AppTheme.baseColor,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Container(
                                                height: 8,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: AppTheme.baseColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      SvgPicture.asset(
                                        'assets/icons/right.svg',
                                        height: 20,
                                        color: AppTheme.baseColor,
                                      ),
                                    ],
                                  ),
                                ),
                                index == 9 ? Container() : SizedBox(height: 12),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    baseColor: AppTheme.baseColor,
                    highlightColor: AppTheme.highlightColor,
                  );
                }
              },
            ),
            SizedBox(height: 92),
          ],
        ),
      ),
    );
  }

  void _getMoreData(int index) async {
    if (!isLoading) {
      blocHome.fetchDocList(
        search,
        regionId,
        cityId,
        professionId,
      );
      page++;
    }
  }

  void _getData() async {
    blocProfile.fetchMe();
  }

  Future<void> _getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // _myImage = prefs.getString('avatar') ?? '';
      _cityName = prefs.getString('city') ?? '';
      _myName = prefs.getString('fullname') ?? 'No nome';
      _myEmail = prefs.getString('email') ?? 'healthymeuser@gmail.com';
    });
  }
}
