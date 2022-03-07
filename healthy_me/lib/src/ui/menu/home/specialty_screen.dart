import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/bloc/home_bloc.dart';
import 'package:healthy_me/src/model/api/profession_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
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
  String obj = '';
  int id = 0;
  bool isLoading = false;

  @override
  void initState() {
    blocHome.fetchCategories(_professionController.text);
    _professionController.addListener(() {
      if (obj != _professionController.text) {
        obj = _professionController.text;
        isLoading = false;
        _getMoreData(1);
      }
    });
    super.initState();
  }

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
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                        fontSize: 14,
                        fontFamily: AppTheme.fontFamily,
                        color: AppTheme.black,
                        height: 1.5,
                      ),
                      cursorColor: AppTheme.purple,
                      decoration: InputDecoration(
                        hintText: 'Search for specialty',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          fontFamily: AppTheme.fontFamily,
                          color: AppTheme.dark,
                          height: 1.5,
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
                            padding: EdgeInsets.only(top: 12, bottom: 24),
                            itemCount: snapshot.data!.results.length,
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
                                      id: id,
                                    ),
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
                          height: 56,
                          margin: EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 24,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: AppTheme.baseColor,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: AppTheme.baseColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              )
                            ],
                          ),
                        ),
                        index == 20
                            ? Container()
                            : Container(
                                height: 1,
                                color: AppTheme.baseColor,
                              ),
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

  void _getMoreData(int index) async {
    if (!isLoading) {
      blocHome.fetchCategories(obj);
    }
  }
}
