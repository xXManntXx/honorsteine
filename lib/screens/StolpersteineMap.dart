import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as geoloc;
import 'package:honorsteine/API_res/stolpersteineData.dart';

class MapPage extends StatefulWidget {
  final Future<List<StolpersteineData>> allVictims;
  final Set<Marker> markers;

  const MapPage({Key? key, required this.allVictims, required this.markers})
      : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng showLocation = const LatLng(51.4357574, 5.472525300000029);
  Set<Marker> allMarkers = {};

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    final location = geoloc.Location();
    bool serviceEnabled;
    geoloc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == geoloc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != geoloc.PermissionStatus.granted) {
        return;
      }
    }

    final currentLocation = await location.getLocation();
    setState(() {
      showLocation = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
    });

    // Move the camera to the current location
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(showLocation, 15.0),
    );

    // Add a marker for the current location
    final ByteData byteData = await rootBundle.load('assets/UserMarker.png');
    final Uint8List imageData = byteData.buffer.asUint8List();
    final BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(imageData);

    setState(() {
      allMarkers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: showLocation,
          infoWindow: InfoWindow(title: 'Current Location'),
          icon: bitmapDescriptor,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: showLocation,
              zoom: 15.0,
            ),
            markers: widget.markers.union(allMarkers),
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    offset: Offset.zero,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // _buildAvatar(),
                  // Add your other widgets here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}