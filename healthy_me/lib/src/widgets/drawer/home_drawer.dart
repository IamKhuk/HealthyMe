import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/advices/advices_screen.dart';
import 'package:healthy_me/src/ui/menu/home/doctor/doctors_screen.dart';
import 'package:healthy_me/src/ui/menu/profile/personal_settings_screen.dart';
import 'package:healthy_me/src/ui/menu/schedule/upcoming_schedules.dart';

class HomeDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final String name;
  final String email;
  final String img;

  HomeDrawer({
    required this.name,
    required this.email,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppTheme.purple,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: img,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PersonalSettingsScreen(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Upcoming Appointments',
                    icon: 'assets/icons/schedule.svg',
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Doctors',
                    icon: 'assets/icons/account.svg',
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Medical Advices',
                    icon: 'assets/icons/heart_beat.svg',
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: AppTheme.white.withOpacity(0.7)),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Support',
                    icon: 'assets/icons/promo.svg',
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Back',
                    icon: "assets/icons/left.svg",
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (context, url) => Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.gray,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 60,
                      width: 60,
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: AppTheme.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                        color: AppTheme.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required String icon,
    VoidCallback? onClicked,
  }) {
    final color = AppTheme.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: SvgPicture.asset(
        icon,
        color: AppTheme.white,
        height: 24,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: 14,
          height: 1.5,
          color: color,
        ),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SchedulesUpcoming(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctorsScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AdvicesScreen(),
        ));
        break;
      case 3:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => DoctorsScreen(),
        // ));
        break;
      case 4:
        break;
    }
  }
}
