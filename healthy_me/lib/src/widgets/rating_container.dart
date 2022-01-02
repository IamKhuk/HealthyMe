import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/utils/utils.dart';

class RatingContainer extends StatefulWidget {
  final double rating;

  RatingContainer({required this.rating});

  @override
  _RatingContainerState createState() => _RatingContainerState();
}

class _RatingContainerState extends State<RatingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      child: Utils.starFormat(widget.rating) == 5
          ? Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  color: AppTheme.yellow,
                ),
                SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  color: AppTheme.yellow,
                ),
                SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  color: AppTheme.yellow,
                ),
                SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  color: AppTheme.yellow,
                ),
                SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/star.svg',
                  color: AppTheme.yellow,
                ),
              ],
            )
          : Utils.starFormat(widget.rating) == 4.5
              ? Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      color: AppTheme.yellow,
                    ),
                    SizedBox(width: 4),
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      color: AppTheme.yellow,
                    ),
                    SizedBox(width: 4),
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      color: AppTheme.yellow,
                    ),
                    SizedBox(width: 4),
                    SvgPicture.asset(
                      'assets/icons/star.svg',
                      color: AppTheme.yellow,
                    ),
                    SizedBox(width: 4),
                    Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          color: AppTheme.dark,
                        ),
                        SvgPicture.asset(
                          'assets/icons/star_h.svg',
                          color: AppTheme.yellow,
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  ],
                )
              : Utils.starFormat(widget.rating) == 4
                  ? Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          color: AppTheme.yellow,
                        ),
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          color: AppTheme.yellow,
                        ),
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          color: AppTheme.yellow,
                        ),
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          color: AppTheme.yellow,
                        ),
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          color: AppTheme.dark,
                        ),
                      ],
                    )
                  : Utils.starFormat(widget.rating) == 3.5
                      ? Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              color: AppTheme.yellow,
                            ),
                            SizedBox(width: 4),
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              color: AppTheme.yellow,
                            ),
                            SizedBox(width: 4),
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              color: AppTheme.yellow,
                            ),
                            SizedBox(width: 4),
                            Stack(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  color: AppTheme.dark,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/star_h.svg',
                                  color: AppTheme.yellow,
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                            SizedBox(width: 4),
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              color: AppTheme.dark,
                            ),
                          ],
                        )
                      : Utils.starFormat(widget.rating) == 3
                          ? Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  color: AppTheme.yellow,
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  color: AppTheme.yellow,
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  color: AppTheme.yellow,
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  color: AppTheme.dark,
                                ),
                                SizedBox(width: 4),
                                SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  color: AppTheme.dark,
                                ),
                              ],
                            )
                          : Utils.starFormat(widget.rating) == 2.5
                              ? Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/star.svg',
                                      color: AppTheme.yellow,
                                    ),
                                    SizedBox(width: 4),
                                    SvgPicture.asset(
                                      'assets/icons/star.svg',
                                      color: AppTheme.yellow,
                                    ),
                                    SizedBox(width: 4),
                                    Stack(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          color: AppTheme.dark,
                                        ),
                                        SvgPicture.asset(
                                          'assets/icons/star_h.svg',
                                          color: AppTheme.yellow,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 4),
                                    SvgPicture.asset(
                                      'assets/icons/star.svg',
                                      color: AppTheme.dark,
                                    ),
                                    SizedBox(width: 4),
                                    SvgPicture.asset(
                                      'assets/icons/star.svg',
                                      color: AppTheme.dark,
                                    ),
                                  ],
                                )
                              : Utils.starFormat(widget.rating) == 2
                                  ? Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          color: AppTheme.yellow,
                                        ),
                                        SizedBox(width: 4),
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          color: AppTheme.yellow,
                                        ),
                                        SizedBox(width: 4),
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          color: AppTheme.dark,
                                        ),
                                        SizedBox(width: 4),
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          color: AppTheme.dark,
                                        ),
                                        SizedBox(width: 4),
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          color: AppTheme.dark,
                                        ),
                                      ],
                                    )
                                  : Utils.starFormat(widget.rating) == 1.5
                                      ? Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/star.svg',
                                              color: AppTheme.yellow,
                                            ),
                                            SizedBox(width: 4),
                                            Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  color: AppTheme.dark,
                                                ),
                                                SvgPicture.asset(
                                                  'assets/icons/star_h.svg',
                                                  color: AppTheme.yellow,
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 4),
                                            SvgPicture.asset(
                                              'assets/icons/star.svg',
                                              color: AppTheme.dark,
                                            ),
                                            SizedBox(width: 4),
                                            SvgPicture.asset(
                                              'assets/icons/star.svg',
                                              color: AppTheme.dark,
                                            ),
                                            SizedBox(width: 4),
                                            SvgPicture.asset(
                                              'assets/icons/star.svg',
                                              color: AppTheme.dark,
                                            ),
                                          ],
                                        )
                                      : Utils.starFormat(widget.rating) == 1
                                          ? Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  color: AppTheme.yellow,
                                                ),
                                                SizedBox(width: 4),
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  color: AppTheme.dark,
                                                ),
                                                SizedBox(width: 4),
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  color: AppTheme.dark,
                                                ),
                                                SizedBox(width: 4),
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  color: AppTheme.dark,
                                                ),
                                                SizedBox(width: 4),
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  color: AppTheme.dark,
                                                ),
                                              ],
                                            )
                                          : Utils.starFormat(widget.rating) ==
                                                  0.5
                                              ? Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icons/star.svg',
                                                          color: AppTheme.dark,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/icons/star_h.svg',
                                                          color:
                                                              AppTheme.yellow,
                                                          alignment: Alignment.centerLeft,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                    SizedBox(width: 4),
                                                    SvgPicture.asset(
                                                      'assets/icons/star.svg',
                                                      color: AppTheme.dark,
                                                    ),
                                                  ],
                                                ),
    );
  }
}
