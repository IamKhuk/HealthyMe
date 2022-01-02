import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorModel {
  String name;
  String pfp;
  String specialty;
  double star;
  LatLng location;
  String busy;
  String bio;

  DoctorModel({
    required this.name,
    required this.pfp,
    required this.specialty,
    required this.star,
    required this.location,
    this.busy = 'Everyday except holidays',
    this.bio =
        'Dr. Krystal Jung is a Korean Dermatologists specialist. She practices general at Yulje Medical Center at South Korea',
  });
}
