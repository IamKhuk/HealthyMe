import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/bloc/home_bloc.dart';
import 'package:healthy_me/src/defaults/categories_list.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/api/doctors_list_model.dart';
import 'package:healthy_me/src/model/event_bus/filter_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/utils/rx_bus.dart';
import 'package:healthy_me/src/widgets/doctor_container.dart';
import 'package:shimmer/shimmer.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  ScrollController _sc = new ScrollController();

  TextEditingController controller = new TextEditingController();
  bool onChanged = false;
  String search = '';
  int professionId = -1;
  int regionId = -1;
  int cityId = -1;
  bool isLoading = false;
  int page = 1;
  int ctgIndex = 0;

  @override
  void initState() {
    page = 1;
    _registerBus();
    _getMoreData(page);
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
    controller.addListener(() {
      if (search != controller.text) {
        search = controller.text;
        isLoading = false;
        _getMoreData(1);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _sc.dispose();
    RxBus.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          'Choose a Doctor',
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
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      endDrawer: Container(
        width: MediaQuery.of(context).size.width - 36,
        color: AppTheme.white,
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
                          'You can search for doctors and choose the appropriate one to make an appointment or chat with him/her.',
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
                    'How to search?',
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/search_form.svg',
                            width: MediaQuery.of(context).size.width - 156,
                          ),
                          SizedBox(width: 8),
                          SvgPicture.asset(
                            'assets/images/filter_form.svg',
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You can search by using this search form like above. Simply type the name of the doctor you want or type the specialty of doctors. Then the results will appear as soon as you type the name. And you can filter the doctors by specialty, region and city.',
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
                          'And you can sort by following categories. Once you choose one of the categories, the results will be sorted in order.',
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child:
                          SvgPicture.asset('assets/images/category_form.svg'),
                    ),
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
                    BottomDialog.showDocFilter(
                      context,
                      (_regionId, _cityId, _professionId) {
                        String key = 'FILTER';
                        RxBus.post(
                          FilterModel(
                            regionId: _regionId,
                            cityId: _cityId,
                            professionId: _professionId,
                          ),
                          tag: key,
                        );
                      },
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
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            StreamBuilder(
              stream: blocHome.getDocs,
              builder: (context, AsyncSnapshot<DoctorsListModel> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
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
                          : categories[ctgIndex].idList.contains(
                                  snapshot.data!.results[index].profession.id)
                              ? Column(
                                  children: [
                                    SizedBox(height: index == 0 ? 0 : 12),
                                    DoctorContainer(
                                        doc: snapshot.data!.results[index]),
                                  ],
                                )
                              : Container();
                    },
                  );
                } else {
                  return Shimmer.fromColors(
                    child: ListView.builder(
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
                                        height: 14,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: AppTheme.baseColor,
                                        ),
                                      ),
                                      SizedBox(height: 10),
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
                    baseColor: AppTheme.baseColor,
                    highlightColor: AppTheme.highlightColor,
                  );
                }
              },
            ),
            SizedBox(height: 24),
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

  void _registerBus() {
    RxBus.register<FilterModel>(tag: "FILTER").listen(
      (event) {
        page = 1;
        cityId = event.cityId;
        regionId = event.regionId;
        professionId = event.professionId;
        isLoading = false;
        _getMoreData(1);
      },
    );
  }
}
