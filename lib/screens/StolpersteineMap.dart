import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honorsteine/screens/victimListPage.dart';
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
                  _StolpersteineInfo(),
                  // Add your other widgets here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _StolpersteineInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(16),
          shrinkWrap: false,
          physics: ScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(60, 0, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Jacob Sibma",
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 12),
                            child: Text(
                              "Ellerhuizen 16",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                  child: Text(
                                    "3.711 m/s",
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              ImageIcon(
                                NetworkImage(
                                    "https://cdn4.iconfinder.com/data/icons/various-forms-of-arrows/32/38__top_down_arrow_routes_directions_arrows_up-128.png"),
                                size: 16,
                                color: Colors.black,
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                  child: Text(
                                    "3.711 m/s",
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),


                  Image(
                      image: NetworkImage("https://cdn.struikelstenengids.nl/images/portrait/4bf75d5c-dc87-4751-8c11-52474a6e61fc.jpg"),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}





