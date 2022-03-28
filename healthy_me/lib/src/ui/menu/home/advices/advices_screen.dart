import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/defaults/advices_list.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/advices/advice_single_screen.dart';
import 'package:healthy_me/src/widgets/advice_container.dart';

class AdvicesScreen extends StatefulWidget {
  @override
  _AdvicesScreenState createState() => _AdvicesScreenState();
}

class _AdvicesScreenState extends State<AdvicesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

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
          'Healthcare Advices',
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You can get the list of advices about how to heal from the disease that is mentioned\nYou can get information about treatment and some of them contains information about how to treat yourself at home without going somewhere out.\n\nIf you are not satisfied with these advices you can go the diagnose page.\nHere you can get diagnosis based on your condition.',
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
      body: ListView.builder(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
        ),
        itemCount: advices.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AdviceSingleScreen(
                      index: index,
                      title: advices[index].title,
                    );
                  },
                ),
              );
            },
            child: AdviceContainer(data: advices[index]),
          );
        },
      ),
    );
  }
}
