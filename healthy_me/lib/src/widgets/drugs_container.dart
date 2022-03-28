import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_me/src/model/drugs_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';

class DrugsContainer extends StatelessWidget {
  final DrugsModel data;

  DrugsContainer({
    required this.data,
    this.isLoadingImage = false,
  });

  final bool isLoadingImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 48,
              right: 24,
              left: 24,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.title.replaceAll('-', ' '),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 16,
                    color: AppTheme.black,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: isLoadingImage
                      ? Container(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.purple),
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: data.img,
                          placeholder: (context, url) => Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: AppTheme.gray,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppTheme.gray,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.error,
                                color: AppTheme.purple,
                              ),
                            ),
                          ),
                          height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              SizedBox(height: 44),
            ],
          ),
        ],
      ),
    );
  }
}
