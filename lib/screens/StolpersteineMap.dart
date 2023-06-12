import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as geoloc;
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? mapController;
  Set<Marker> markers = Set();
  LatLng showLocation = LatLng(51.4357574, 5.472525300000029);

  @override
  void initState() {
    fetchAPI();
    getCurrentLocation();
    super.initState();
  }

  Future<void> fetchAPI() async {
    print(">>> Fetching API ...");
    final response = await http.get(Uri.parse(
        'https://api.struikelstenengids.nl/v2/export/stones?secret=yONOtKGoGO9u9O8pC247jKl9NcDxEl54C2b8N06nzgF9WR6S1I'));
    if (response.statusCode == 200) {
      print(">>> Answer received !");
      var data = json.decode(response.body) as List<dynamic>;
      List<StolpersteineData> locationsList = [];
      data.forEach((element) {
        locationsList.add(StolpersteineData.fromJson(element));
      });
      setState(() {
        for (var location in locationsList) {
          markers.add(Marker(
            markerId: MarkerId(location.id.toString()),
            position: LatLng(location.location[0], location.location[1]),
            infoWindow: InfoWindow(
              title: location.name,
              snippet: location.address,
            ),
            icon: BitmapDescriptor.defaultMarker,

          ));
        }
      });
    } else {
      print(">>> Failed to retrieve data");
      throw Exception('Failed to load data');
    }
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
      showLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map in Flutter"),
        backgroundColor: Colors.amber,
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: showLocation,
          zoom: 15.0,
        ),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
