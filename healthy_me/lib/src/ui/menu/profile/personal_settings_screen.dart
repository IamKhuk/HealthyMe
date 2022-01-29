import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_me/src/defaults/me.dart';
import 'package:healthy_me/src/dialog/bottom_dialog.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalSettingsScreen extends StatefulWidget {
  @override
  _PersonalSettingsScreenState createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  final picker = ImagePicker();
  String gender = "";
  bool isLoadingImage = false;
  String pfp = me.pfp;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  String name = me.name;

  @override
  void initState() {
    _nameController.text = name;
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
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(24),
              children: [
                Row(
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: isLoadingImage
                            ? Container(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme.white),
                                ),
                              )
                            : Image.asset(
                                pfp,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Image',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: AppTheme.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // BottomDialog.createUploadImageChat(
                                //   context,
                                //   () async {
                                //     final pickedFile = await picker.pickImage(
                                //       source: ImageSource.gallery,
                                //     );
                                //     if (pickedFile != null) {
                                //       setState(() {
                                //         isLoadingImage = true;
                                //         pfp = pickedFile.path;
                                //       });
                                //
                                //       SharedPreferences prefs =
                                //           await SharedPreferences.getInstance();
                                //       prefs.setString(
                                //         "avatar",
                                //         pickedFile.path,
                                //       );
                                //       setState(() {
                                //         isLoadingImage = false;
                                //       });
                                //     }
                                //   },
                                //   () async {
                                //     final pickedFile = await picker.pickImage(
                                //       source: ImageSource.camera,
                                //     );
                                //     if (pickedFile != null) {
                                //       setState(() {
                                //         isLoadingImage = true;
                                //         pfp = pickedFile.path;
                                //       });
                                //
                                //       SharedPreferences prefs =
                                //           await SharedPreferences.getInstance();
                                //       prefs.setString(
                                //         "avatar",
                                //         pickedFile.path,
                                //       );
                                //       setState(() {
                                //         isLoadingImage = false;
                                //       });
                                //     }
                                //   },
                                // );
                              },
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.375,
                                  color: AppTheme.yellow,
                                ),
                              ),
                            ),
                            Container(
                              height: 18,
                              width: 1,
                              color: AppTheme.dark,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            GestureDetector(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.375,
                                  color: AppTheme.red,
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
                      left: 16,
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
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 11,
                            bottom: 11,
                            right: 12,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/user.svg',
                            color: AppTheme.purple,
                          ),
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
                      left: 16,
                      right: 20,
                      top: 2,
                    ),
                    child: TextFormField(
                      controller: _userController,
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
                        hintText: 'Enter your user name',
                        hintStyle: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.dark.withOpacity(0.6),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 11,
                            bottom: 11,
                            right: 12,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/user.svg',
                            color: AppTheme.purple,
                          ),
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
                      left: 16,
                      right: 20,
                      top: 2,
                    ),
                    child: TextFormField(
                      controller: _emailController,
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
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          color: AppTheme.dark.withOpacity(0.6),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            right: 12,
                          ),
                          child: Icon(
                            Icons.email_outlined,
                            color: AppTheme.purple,
                            size: 28,
                          ),
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
                                  borderRadius:
                                  BorderRadius.circular(16),
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
                                  borderRadius:
                                  BorderRadius.circular(16),
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
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  left: 36,
                  right: 36,
                  bottom: 24,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 56,
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
