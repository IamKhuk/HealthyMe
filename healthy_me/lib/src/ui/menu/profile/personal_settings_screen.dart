import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/bloc/profile_bloc.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/model/api/profile_model.dart';
import 'package:healthy_me/src/model/api/region_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/profile/cities_screen.dart';
import 'package:healthy_me/src/ui/menu/profile/regions_screen.dart';
import 'package:healthy_me/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main_screen.dart';

class PersonalSettingsScreen extends StatefulWidget {
  @override
  _PersonalSettingsScreenState createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  final picker = ImagePicker();
  String gender = "";
  bool isLoadingImage = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  DateTime birthDate = DateTime.now();
  String region = '';
  String city = '';
  bool isLoading = false;
  int regionId = 0;
  int cityId = 0;

  @override
  void initState() {
    blocProfile.fetchMeCache();
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
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainScreen();
                    },
                  ),
                );
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
          'Personal Settings',
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
        stream: blocProfile.getInfoCache,
        builder: (context, AsyncSnapshot<ProfileData> snapshot) {
          _nameController.text = snapshot.data!.fullName;
          _userController.text = snapshot.data!.username;
          _emailController.text = snapshot.data!.email;
          _phoneController.text = Utils.phoneTextFormat(snapshot.data!.phone);
          region = snapshot.data!.region;
          city = snapshot.data!.city;
          birthDate = snapshot.data!.birthDate;
          gender = snapshot.data!.gender;
          if (snapshot.hasData) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.all(24),
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 96,
                            width: 96,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: isLoadingImage
                                  ? Container(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppTheme.purple),
                                        ),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: snapshot.data!.avatar,
                                      placeholder: (context, url) => Container(
                                        height: 64,
                                        width: 64,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(64),
                                          color: AppTheme.dark,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        height: 64,
                                        width: 64,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(64),
                                          color: AppTheme.gray,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.error,
                                            color: AppTheme.purple,
                                          ),
                                        ),
                                      ),
                                      height: 64,
                                      width: 64,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Image',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: AppTheme.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BottomDialog.createUploadImageChat(
                                        context,
                                        () async {
                                          final pickedFile =
                                              await picker.pickImage(
                                            source: ImageSource.gallery,
                                          );
                                          if (pickedFile != null) {
                                            setState(() {
                                              isLoadingImage = true;
                                            });
                                            var response = await Repository()
                                                .fetchProfileImageSend(
                                              pickedFile.path,
                                            );
                                            if (response.isSuccess) {
                                              var result =
                                                  ProfileModel.fromJson(
                                                      response.result);
                                              setState(() {
                                                isLoadingImage = false;
                                                snapshot.data!.avatar =
                                                    result.user.avatar;
                                              });
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setString(
                                                "avatar",
                                                result.user.avatar,
                                              );
                                              blocProfile.fetchMe();
                                              setState(() {
                                                isLoadingImage = false;
                                              });
                                            } else {
                                              BottomDialog.showActionFailed(
                                                context,
                                                'Action Failed',
                                                'Could not upload the image, please try again',
                                              );
                                              setState(() {
                                                isLoadingImage = false;
                                              });
                                            }
                                          }
                                        },
                                        () async {
                                          final pickedFile =
                                              await picker.pickImage(
                                            source: ImageSource.camera,
                                          );
                                          if (pickedFile != null) {
                                            setState(() {
                                              isLoadingImage = true;
                                            });
                                            var response = await Repository()
                                                .fetchProfileImageSend(
                                              pickedFile.path,
                                            );
                                            if (response.isSuccess) {
                                              var result =
                                                  ProfileModel.fromJson(
                                                      response.result);
                                              setState(() {
                                                isLoadingImage = false;
                                                snapshot.data!.avatar =
                                                    result.user.avatar;
                                              });
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setString(
                                                "avatar",
                                                result.user.avatar,
                                              );
                                              blocProfile.fetchMe();
                                            } else {
                                              BottomDialog.showActionFailed(
                                                context,
                                                'Action Failed',
                                                'Could not upload the image, please try again',
                                              );
                                            }
                                          }
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 32,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  192) /
                                              2,
                                      decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 75,
                                            spreadRadius: 0,
                                            color: Color(0xFF939393)
                                                .withOpacity(0.07),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 1.375,
                                            color: AppTheme.purple,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      height: 32,
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  192) /
                                              2,
                                      decoration: BoxDecoration(
                                        color: AppTheme.purple,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 75,
                                            spreadRadius: 0,
                                            color: Color(0xFF939393)
                                                .withOpacity(0.07),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 1.375,
                                            color: AppTheme.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 75,
                              spreadRadius: 0,
                              color: Color(0xFF939393).withOpacity(0.07),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 2,
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: AppTheme.purple,
                            enableInteractiveSelection: true,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.dark,
                            ),
                            autofocus: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your full name',
                              hintStyle: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                height: 1.5,
                                color: AppTheme.dark.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Username',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 75,
                              spreadRadius: 0,
                              color: Color(0xFF939393).withOpacity(0.07),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 2,
                          ),
                          child: TextFormField(
                            controller: _userController,
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: AppTheme.purple,
                            // initialValue: snapshot.data!.username,
                            enableInteractiveSelection: true,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.dark,
                            ),
                            autofocus: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                height: 1.5,
                                color: AppTheme.dark.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 75,
                              spreadRadius: 0,
                              color: Color(0xFF939393).withOpacity(0.07),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 2,
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            textAlignVertical: TextAlignVertical.center,
                            // initialValue: snapshot.data!.email,
                            cursorColor: AppTheme.purple,
                            enableInteractiveSelection: true,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.dark,
                            ),
                            autofocus: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                height: 1.5,
                                color: AppTheme.dark.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  gender = "man";
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 270),
                                      curve: Curves.easeInOut,
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border:
                                            Border.all(color: AppTheme.purple),
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 14,
                                          width: 14,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: gender == "man"
                                                ? AppTheme.orange
                                                : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  gender = "woman";
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 270),
                                      curve: Curves.easeInOut,
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border:
                                            Border.all(color: AppTheme.purple),
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 14,
                                          width: 14,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: gender == "woman"
                                                ? AppTheme.orange
                                                : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Female',
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Phone number',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 75,
                              spreadRadius: 0,
                              color: Color(0xFF939393).withOpacity(0.07),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 2,
                          ),
                          child: TextFormField(
                            controller: _phoneController,
                            textAlignVertical: TextAlignVertical.center,
                            // initialValue: snapshot.data!.phone,
                            cursorColor: AppTheme.purple,
                            enableInteractiveSelection: true,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.dark,
                            ),
                            autofocus: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                height: 1.5,
                                color: AppTheme.dark.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Birth Date',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          BottomDialog.showDateTime(
                            context,
                            (data) {
                              setState(() {
                                birthDate = data;
                              });
                            },
                            birthDate,
                          );
                        },
                        child: Container(
                          height: 56,
                          width: MediaQuery.of(context).size.width - 32,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color(0xFF939393).withOpacity(0.07),
                              ),
                            ],
                          ),
                          child: Text(
                            (birthDate.day.toString().length == 1
                                    ? '0' + birthDate.day.toString()
                                    : birthDate.day.toString()) +
                                '/' +
                                (birthDate.month.toString().length == 1
                                    ? '0' + birthDate.month.toString()
                                    : birthDate.month.toString()) +
                                '/' +
                                birthDate.year.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              fontFamily: AppTheme.fontFamily,
                              color: AppTheme.dark,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Region',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegionsScreen(
                                  data: RegionsResult(
                                    id: regionId,
                                    name: snapshot.data!.region,
                                  ),
                                  changed: (
                                    _name,
                                    _id,
                                  ) {
                                    setState(
                                      () {
                                        snapshot.data!.region = _name;
                                        region = _name;
                                        regionId = _id;
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color(0xFF939393).withOpacity(0.07),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  region.length == 0 ? 'Choose region' : region,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: AppTheme.dark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'City',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CitiesScreen(
                                  parentId: regionId,
                                  data: RegionsResult(
                                    id: cityId,
                                    name: snapshot.data!.city,
                                  ),
                                  changed: (
                                    _name,
                                    _id,
                                  ) {
                                    setState(
                                      () {
                                        snapshot.data!.city = _name;
                                        city = _name;
                                        cityId = _id;
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 75,
                                spreadRadius: 0,
                                color: Color(0xFF939393).withOpacity(0.07),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  city.length == 0 ? 'Choose city' : city,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                    color: AppTheme.dark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 90),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        snapshot.data!.fullName = _nameController.text;
                        snapshot.data!.gender = gender;
                        var response = await Repository()
                            .fetchUpdateProfile(snapshot.data!);
                        if (response.isSuccess) {
                          setState(() {
                            isLoading = false;
                          });
                          ProfileModel data =
                              ProfileModel.fromJson(response.result);
                          if (data.status == 1) {
                            blocProfile.fetchUpdateInfo(data);
                            Navigator.pop(context);
                          } else {
                            BottomDialog.showActionFailed(
                              context,
                              'Something went wrong',
                              response.result["msg"] ?? "Please try again",
                            );
                          }
                        } else if (response.status == -1) {
                          setState(() {
                            isLoading = false;
                          });
                          BottomDialog.showActionFailed(
                            context,
                            'Connection Failed',
                            'You do not have internet connection, please try again',
                          );
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          BottomDialog.showActionFailed(
                            context,
                            'Something went wrong',
                            response.result["msg"] ?? "Please try again",
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
                            'Save Changes',
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
                isLoading == true
                    ? Container(
                        color: AppTheme.black.withOpacity(0.45),
                        child: Center(
                          child: Container(
                            height: 96,
                            width: 96,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 25,
                                  spreadRadius: 0,
                                  color: AppTheme.dark.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.purple),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
