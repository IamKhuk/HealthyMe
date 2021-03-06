import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:healthy_me/src/defaults/advices_list.dart';
import 'package:healthy_me/src/defaults/conditions_list.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/api/diagnose_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/advices/advice_single_screen.dart';
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
  bool isLoading = false;
  late List<Diagnostic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.bg,
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
        centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AdviceSingleScreen(
                                index: advices.indexOf(item),
                                title: 'Treatment',
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
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
                onTap: () async {
                  if (_getSelectedItem()!.length > 0) {
                    for (int i = 0; i <= _getSelectedItem()!.length - 1; i++) {
                      _ids.add(_getSelectedItem()![i].index);
                    }
                    setState(() {
                      isLoading = true;
                    });
                    var response = await Repository().fetchDiagnose(_ids);
                    if (response.isSuccess) {
                      setState(() {
                        isLoading = false;
                      });
                      var result = DiagnoseApiModel.fromJson(response.result);
                      if (result.status == 1) {
                        data = result.diagnostics;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DiagnoseResultScreen(
                                items: _getSelectedItem(),
                                ids: _ids,
                                data: data,
                              );
                            },
                          ),
                        );
                        _ids = [];
                      } else {
                        BottomDialog.showAction(
                          context,
                          'Something went wrong',
                          'Please try again after some time',
                          'assets/icons/alert.svg',
                        );
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      if (response.status == -1) {
                        BottomDialog.showAction(
                          context,
                          'Connection Failed',
                          'You do not have internet connection, please try again',
                          'assets/icons/alert.svg',
                        );
                      } else {
                        BottomDialog.showAction(
                          context,
                          'Server error',
                          'Something went wrong, Please try again after some time',
                          'assets/icons/alert.svg',
                        );
                      }
                    }
                  } else {
                    BottomDialog.showAction(
                      context,
                      'Action Failed',
                      'Please choose at least one condition to continue',
                      'assets/icons/alert.svg',
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
