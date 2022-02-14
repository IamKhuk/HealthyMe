import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/bloc/profile_bloc.dart';
import 'package:healthy_me/src/model/api/region_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/animated_button.dart';
import 'package:shimmer/shimmer.dart';

class CitiesScreen extends StatefulWidget {
  final Function(
    String _name,
    int _id,
  ) changed;
  final RegionsResult data;
  final int parentId;

  CitiesScreen({
    required this.data,
    required this.changed,
    required this.parentId,
  });

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  String name = '';
  int id = 0;

  @override
  void initState() {
    setState(() {
      name = widget.data.name;
      id = widget.data.id;
    });
    blocProfile.fetchMeCity(widget.parentId);
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
          'Choose Location',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: AppTheme.fontFamily,
            height: 1.5,
            color: AppTheme.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: blocProfile.getCities,
        builder: (context, AsyncSnapshot<RegionModel> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.data.length,
                  padding: EdgeInsets.only(top: 4, bottom: 24),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              name = snapshot.data!.data[index].name;
                              id = snapshot.data!.data[index].id;
                            });
                          },
                          child: AnimatedButton(
                            data: snapshot.data!.data[index],
                            id: id,
                          ),
                        ),
                        index == snapshot.data!.data.length - 1
                            ? Container()
                            : Container(
                                height: 1,
                                color: AppTheme.gray,
                              ),
                      ],
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (name != "") {
                          Navigator.pop(context);
                          widget.changed(
                            name,
                            id,
                          );
                        }
                      },
                      child: Container(
                        height: 56,
                        margin: EdgeInsets.only(
                          left: 36,
                          right: 36,
                          bottom: 24,
                        ),
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
                            'Choose',
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
    );
  }
}
