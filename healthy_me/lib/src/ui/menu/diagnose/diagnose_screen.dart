import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:healthy_me/src/defaults/advices_list.dart';
import 'package:healthy_me/src/defaults/conditions_list.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({Key? key}) : super(key: key);

  @override
  _DiagnoseScreenState createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  @override
  void initState() {
    for(int i = 0; i<conditions.length; i++){
      _items.add(conditions[i].name);
    }
    super.initState();
  }
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items = [];

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
              SizedBox(height: 124),
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
                child: ListView(),
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
              Tags(
                key: _tagStateKey,
                textField: TagsTextField(
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppTheme.fontFamily,
                  ),
                  constraintSuggestion: true,
                  suggestions: [],
                  //width: double.infinity, padding: EdgeInsets.symmetric(horizontal: 10),
                  onSubmitted: (String str) {
                    // Add item to the data source.
                    setState(() {
                      // required
                      _items.add(Item(
                        title: str,
                        active: true,
                        index: 1,
                      ));
                    });
                  },
                ),
                itemCount: _items.length,
                itemBuilder: (int index){
                  final item = _items[index];
                  return ItemTags(
                    key: Key(index.toString()),
                    index: index, // required
                    title: item.title,
                    active: item.active,
                    customData: item.customData,
                    textStyle: TextStyle( fontSize: 12),
                    combine: ItemTagsCombine.withTextBefore,
                    // icon: ItemTagsIcon(
                    //   icon: Icons.add,
                    // ), // OR null,
                    // removeButton: ItemTagsRemoveButton(
                    //   onRemoved: (){
                    //     setState(() {
                    //       _items.removeAt(index);
                    //     });
                    //     return true;
                    //   },
                    // ),
                    onPressed: (item) => print(item),
                    onLongPressed: (item) => print(item),
                  );

                },
              ),
              Spacer(),
              Container(
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
              SizedBox(height: 96),
            ],
          ),
        ],
      ),
    );
  }
}
