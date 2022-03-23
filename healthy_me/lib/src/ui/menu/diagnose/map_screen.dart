import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthy_me/src/theme/app_theme.dart';
import 'package:healthy_me/src/widgets/map_style.dart';

class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;
  late LatLng location;

  @override
  void initState() {
    location = LatLng(41.321368225281276, 69.2543618158099);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            scrollGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: location,
              zoom: 16,
            ),
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationEnabled: false,
            markers: <Marker>{_createMarker()},
            onMapCreated: _onMapCreated,
          ),
          Container(
            height: MediaQuery.of(context).size.height * ((94) / 812),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
            color: AppTheme.bg.withOpacity(0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
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
                    Spacer(),
                    Text(
                      'Your Location',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: AppTheme.fontFamily,
                        height: 1.5,
                        color: AppTheme.black,
                      ),
                    ),
                    Spacer(),
                    SizedBox(width: 40),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: MarkerId("marker_1"),
        position: location,
        icon: _markerIcon!,
      );
    } else {
      return Marker(
        markerId: MarkerId("marker_1"),
        position: location,
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
