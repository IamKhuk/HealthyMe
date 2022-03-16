import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:healthy_me/src/model/diseases_probability.dart';
import 'package:healthy_me/src/model/drugs_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/diagnose/waiting_screen.dart';
import 'package:healthy_me/src/utils/percentages_function.dart';
import 'package:healthy_me/src/widgets/drugs_container.dart';
import 'package:healthy_me/src/widgets/percentage_rich_text.dart';

class DiagnoseResultScreen extends StatefulWidget {
  final List<Item>? items;
  final List<int?> ids;

  DiagnoseResultScreen({
    required this.items,
    required this.ids,
  });

  @override
  _DiagnoseResultScreenState createState() => _DiagnoseResultScreenState();
}

class _DiagnoseResultScreenState extends State<DiagnoseResultScreen> {
  @override
  void initState() {
    _items = widget.items!;
    _list = percentages(widget.ids);
    List<DrugsModel> drugs = [];
    for (int i = 0; i <= _list.length - 1; i++) {
      if (_list[i].percentage > 75) {
        _listBool.add(true);
      } else {
        _listBool.add(false);
      }
      for (int j = 0; j <= _list[i].drugs.length - 1; j++) {
        drugs.add(_list[i].drugs[j]);
      }
    }
    _drugs = drugs;
    if (_listBool.contains(true)) {
      _diagnose = _list[_listBool.indexOf(true)].diagnose;
      onDiagnose = true;
    } else {
      List<String> recList = [];
      for (int i = 0; i <= _listBool.length - 1; i++) {
        recList.add(_list[i].rec);
      }
      onDiagnose = false;
      _diagnose = recList;
    }
    super.initState();
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items = [];
  late List<DiseaseProbability> _list;
  late bool onDiagnose;
  late List<String> _diagnose;
  late List<bool> _listBool = [];
  late List<DrugsModel> _drugs;

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
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/left.svg',
                    color: AppTheme.purple,
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: Text(
          'Your Results',
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
                  // _scaffoldKey.currentState!.openEndDrawer();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/help.svg',
                    color: AppTheme.purple,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 36),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 24),
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 24),
                  Text(
                    'Selected conditions',
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
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      title: item.title,
                      active: item.active,
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      activeColor: AppTheme.orange,
                      splashColor: AppTheme.purple,
                      colorShowDuplicate: AppTheme.purple,
                      textColor: AppTheme.red,
                      pressEnabled: false,
                      textActiveColor: AppTheme.white,
                      elevation: 0,
                      color: AppTheme.white,
                      border: Border.all(color: AppTheme.orange),
                      borderRadius: BorderRadius.circular(12),
                      customData: '',
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.normal,
                      ),
                      combine: ItemTagsCombine.withTextBefore,
                      onPressed: (item) {
                        print(item);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 24),
                  Text(
                    'Disease Probability',
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
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        PercentageText(data: _list[index]),
                        index == _list.length - 1
                            ? SizedBox(height: 0)
                            : SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 24),
                  Text(
                    onDiagnose == true ? 'Diagnose' : 'Suggestions',
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
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _diagnose.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          _diagnose[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            fontFamily: AppTheme.fontFamily,
                            height: 1.5,
                            color: AppTheme.dark,
                          ),
                        ),
                        index == _list.length - 1
                            ? SizedBox(height: 0)
                            : SizedBox(height: 12),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 24),
                  Text(
                    'Suggested Medicine',
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
              SizedBox(height: 12),
              Container(
                height: 144,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 24, right: 8),
                  itemCount: _drugs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return DrugsContainer(data: _drugs[index]);
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 24),
                  Text(
                    'Emergency',
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
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'If you feel yourself so bad, please TAP THE SOS button immediately, this action calls an ambulance automatically to your location',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 72),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return WaitingScreen();
                      },
                    ),
                  );
                },
                child: Container(
                  height: 56,
                  width: (MediaQuery.of(context).size.width - 72) / 3,
                  margin: EdgeInsets.only(left: 24, bottom: 24),
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
                      'SOS',
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
            ],
          )
        ],
      ),
    );
  }
}
