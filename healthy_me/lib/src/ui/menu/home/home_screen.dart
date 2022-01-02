import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/defaults/doctors_list.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/visit_container.dart';

import '../../main_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = new TextEditingController();
  bool onChanged = false;



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
                onTap: () {},
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
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 12),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width-132,
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
                      prefixIcon: onChanged == false && controller.text.length == 0
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
                  onTap: () {},
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
                SizedBox(width: 12),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
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
                  onTap: (){
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: 15),
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
            VisitContainer(doc: doc_02, time: [DateTime.now(), DateTime.now()]),
            SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
