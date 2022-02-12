import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthy_me/src/model/chat_model.dart';
import 'package:healthy_me/src/model/doctor_model.dart';
import 'package:healthy_me/src/model/msg_model.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/ui/menu/home/chat_screen.dart';
import 'package:healthy_me/src/ui/menu/home/doctor/doctor_map.dart';
import 'package:healthy_me/src/ui/menu/schedule/appointment_screen.dart';
import 'package:healthy_me/src/widgets/map_style.dart';
import 'package:healthy_me/src/widgets/rating_container.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final DoctorModel doc;

  DoctorDetailsScreen({required this.doc});

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  late ChatModel _chat;
  bool full = false;
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;

  @override
  void initState() {
    _chat = ChatModel(
      user: widget.doc,
      msg: [
        MsgModel(msg: 'Hey dude', time: DateTime.now()),
        MsgModel(msg: "How are you doing", time: DateTime.now()),
      ],
      isRead: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Scaffold(
      key: _scaffoldKey,
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
          'Doctor Detail',
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
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: AppTheme.gray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset('assets/icons/help.svg'),
                ),
              ),
            ],
          ),
          SizedBox(width: 36),
        ],
      ),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Container(
        color: AppTheme.white,
        width: MediaQuery.of(context).size.width - 36,
        child: Drawer(
          elevation: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView(
                padding: EdgeInsets.all(24),
                children: [
                  SizedBox(height: 24),
                  Text(
                    'What can I do in this page?',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You can get detailed information about the doctor such as his/her biography, location and personal career. Once you learn who the doctor is then you can contact him/her, chat with the doctor and make an appointment with the him/her.',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.8,
                            color: AppTheme.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'How to chat?',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.orange,
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
                      child: SvgPicture.asset(
                        'assets/icons/chat.svg',
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You can start chatting after tapping the button like above one, once you tap it, you will be directed to chatting screen.\n\nNote: Please be respectful when you chat with the doctor.',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.8,
                            color: AppTheme.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'How to make an appointment?',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width - 74,
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
                        'Make Appointment',
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'If you tap the button like this one above, you will be directed to the appointment screen and there you can schedule an appointment.',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.8,
                            color: AppTheme.dark,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 90),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 61,
                      width: 61,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.white,
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
                        child: SvgPicture.asset(
                          'assets/icons/x.svg',
                          color: AppTheme.purple,
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 36),
                  Container(
                    height: 120,
                    width: 106,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.doc.pfp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'Dr. ' + widget.doc.name,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            height: 1.5,
                            color: AppTheme.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          widget.doc.specialty,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: AppTheme.dark,
                          ),
                        ),
                        SizedBox(height: 14),
                        Row(
                          children: [
                            RatingContainer(rating: widget.doc.star),
                            SizedBox(width: 8),
                            Text(
                              '(' + widget.doc.reviews.toString() + ' reviews)',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                fontFamily: AppTheme.fontFamily,
                                height: 1.5,
                                color: AppTheme.dark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 36),
                ],
              ),
              SizedBox(height: 28),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 164),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        top: 12,
                        left: 36,
                        right: 36,
                        bottom: 24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(48),
                          topRight: Radius.circular(48),
                        ),
                        color: AppTheme.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Spacer(),
                              Container(
                                height: 4,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppTheme.gray,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Biography',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.black,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.doc.bio,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    height: 1.8,
                                    color: AppTheme.dark,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: full == false ? 3 : 99,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    full = !full;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  color: Colors.transparent,
                                  child:
                                      Text(full == false ? 'Read more' : 'Less',
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontFamily,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            height: 1.5,
                                            color: AppTheme.orange,
                                          )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Location',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.black,
                            ),
                          ),
                          SizedBox(height: 14),
                          Container(
                            height: 136,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppTheme.light,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: GoogleMap(
                                    myLocationButtonEnabled: false,
                                    mapType: MapType.normal,
                                    scrollGesturesEnabled: true,
                                    initialCameraPosition: CameraPosition(
                                      target: widget.doc.location,
                                      zoom: 16,
                                    ),
                                    zoomControlsEnabled: false,
                                    compassEnabled: false,
                                    myLocationEnabled: false,
                                    markers: <Marker>{_createMarker()},
                                    onMapCreated: _onMapCreated,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return DoctorMapScreen(doc: widget.doc);
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 136,
                                    width: MediaQuery.of(context).size.width-72,
                                    color: Colors.transparent,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Schedule',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: AppTheme.black,
                            ),
                          ),
                          SizedBox(height: 14),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppTheme.orangeLight,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.doc.busy,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontFamily,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      height: 1.5,
                                      color: AppTheme.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 92),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatScreen(data: _chat);
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppTheme.orange,
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
                          child: SvgPicture.asset(
                            'assets/icons/chat.svg',
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AppointmentScreen();
                              },
                            ),
                          );
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
                              'Make Appointment',
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

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: MarkerId("marker_1"),
        position: widget.doc.location,
        icon: _markerIcon!,
      );
    } else {
      return Marker(
        markerId: MarkerId("marker_1"),
        position: widget.doc.location,
      );
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(
        context,
        size: Size.square(64),
      );
      BitmapDescriptor.fromAssetImage(
        imageConfiguration,
        'assets/images/location_pin.png',
      ).then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      controller!.setMapStyle(MapStyle().retro);
    });
  }
}