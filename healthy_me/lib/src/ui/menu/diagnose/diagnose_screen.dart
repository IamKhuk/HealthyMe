import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:healthy_me/src/defaults/advices_list.dart';
import 'package:healthy_me/src/defaults/conditions_list.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

import 'diagnose_result_screen.dart';

class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({Key? key}) : super(key: key);

  @override
  _DiagnoseScreenState createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  @override
  void initState() {
    for (int i = 0; i < conditions.length; i++) {
      _items.add(Item(title: conditions[i].name, active: false, index: i));
    }
    super.initState();
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items = [];
  List<int?> _ids = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bg,
        brightness: Brightness.light,
        title: Text(
          'Diagnose',
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
              SizedBox(height: 130),
              Row(
                children: [
                  SizedBox(width: 24),
                  Text(
                    'What is making you worry?',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      fontFamily: AppTheme.fontFamily,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: Tags(
                        key: _tagStateKey,
                        alignment: WrapAlignment.start,
                        itemCount: _items.length,
                        spacing: 8,
                        itemBuilder: (int index) {
                          final item = _items[index];
                          return ItemTags(
                            key: Key(index.toString()),
                            index: index,
                            // required
                            title: item.title,
                            active: item.active,
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            activeColor: AppTheme.orange,
                            splashColor: AppTheme.purple,
                            colorShowDuplicate: AppTheme.orange,
                            textColor: AppTheme.purple,
                            textActiveColor: AppTheme.white,
                            elevation: 0,
                            color: AppTheme.white,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(12),
                            customData: item.customData,
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.normal,
                            ),
                            combine: ItemTagsCombine.withTextBefore,
                            onPressed: (item) => print(item),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 168),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 16),
              Container(
                height: 96,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items: advices.map((item) {
                    return Container(
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 96,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                item.img,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Container(
                            height: 96,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppTheme.gray,
                                  AppTheme.gray.withOpacity(0.7),
                                  AppTheme.gray.withOpacity(0.4),
                                  AppTheme.gray.withOpacity(0.1),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                        fontFamily: AppTheme.fontFamily,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {},
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    pauseAutoPlayOnTouch: true,
                    viewportFraction: 0.5,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  if (_getSelectedItem()!.length>0) {
                    for (int i = 0;
                    i <= _getSelectedItem()!.length - 1;
                    i++) {
                      _ids.add(_getSelectedItem()![i].index);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DiagnoseResultScreen(
                            items: _getSelectedItem(),
                            ids: _ids,
                          );
                        },
                      ),
                    );
                  }
                },
                child: Container(
                  height: 56,
                  margin: EdgeInsets.symmetric(horizontal: 24),
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
                      'Diagnose',
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
              SizedBox(height: 96),
            ],
          ),
        ],
      ),
    );
  }

  List<Item>? _getSelectedItem() {
    List<Item>? selected = [];
    List<Item>? list = _tagStateKey.currentState?.getAllItem;
    if (list != null)
      list.where((a) => a.active == true).forEach((a) => print(a.title));
    selected = list!.where((element) => element.active == true).toList();
    return selected;
  }
}
