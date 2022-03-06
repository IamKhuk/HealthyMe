import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/bloc/home_bloc.dart';
import 'package:healthy_me/src/model/api/profession_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'dart:io';
import 'package:healthy_me/src/widgets/specialty_button.dart';
import 'package:shimmer/shimmer.dart';

class SpecialtyScreen extends StatefulWidget {
  final Function(int professionId, String professionName) onChanged;

  SpecialtyScreen({required this.onChanged});

  @override
  _SpecialtyScreenState createState() => _SpecialtyScreenState();
}

class _SpecialtyScreenState extends State<SpecialtyScreen> {
  TextEditingController _professionController = new TextEditingController();
  ScrollController _sc = new ScrollController();

  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Choose Specialty',
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
                // onTap: () {
                //   _scaffoldKey.currentState!.openEndDrawer();
                // },
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: StreamBuilder(
          stream: blocHome.getCategories,
          builder: (context, AsyncSnapshot<ProfessionModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width - 32,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      autofocus: false,
                      controller: _professionController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: AppTheme.fontFamily,
                        color: AppTheme.black,
                        height: 1.5,
                      ),
                      cursorColor: AppTheme.purple,
                      decoration: InputDecoration(
                        hintText: 'Search for specialty',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: AppTheme.fontFamily,
                          color: AppTheme.dark,
                          height: 1.375,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  snapshot.data!.results.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                            top: 12,
                            left: 16,
                            right: 16,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  _professionController.text = '';
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                height: 56,
                                child: Center(
                                  child: Text(
                                    'There is no specialty like this',
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      height: 1.5,
                                      color: AppTheme.orange,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            controller: _sc,
                            padding: EdgeInsets.only(left: 16),
                            itemCount: snapshot.data!.results.length + 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        id = snapshot.data!.results[index].id;
                                      });
                                      widget.onChanged(
                                        snapshot.data!.results[index].id,
                                        snapshot.data!.results[index].name,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: SpecialtyButton(
                                        data: snapshot.data!.results[index],
                                        id: id),
                                  ),
                                  index == snapshot.data!.results.length - 1
                                      ? Container(
                                          height: Platform.isIOS ? 32 : 24,
                                        )
                                      : Container(
                                          height: 1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              32,
                                          color: AppTheme.gray,
                                        ),
                                ],
                              );
                            },
                          ),
                        ),
                ],
              );
            } else {
              return Shimmer.fromColors(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 80,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: AppTheme.baseColor,
                                  borderRadius: BorderRadius.circular(48),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: AppTheme.baseColor,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        height: 12,
                                        width: 44,
                                        decoration: BoxDecoration(
                                          color: AppTheme.baseColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        height: 12,
                                        width: 52,
                                        decoration: BoxDecoration(
                                          color: AppTheme.baseColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 16,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      color: AppTheme.baseColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    height: 12,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: AppTheme.baseColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 32),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 16,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      color: AppTheme.baseColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    height: 12,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: AppTheme.baseColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        index == 20
                            ? Container()
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 1,
                                color: AppTheme.baseColor,
                              )
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
    );
  }
}
