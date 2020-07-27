import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/widget/color_app.dart';

class ProfileView extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ProfileView> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Position position;
  final Map<String, Marker> _markers = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: _markers.values.toSet(),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _goToTheDirectLocation();
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Row(
        children: <Widget>[
          Transform.translate(
            offset: Offset(3,8),
            child: FloatingActionButton.extended(
              onPressed: set,
              backgroundColor: colorApp,
              label: Text('location'),
              icon: Icon(CupertinoIcons.location_solid),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  void set() {
    setState(() {});
  }

  Future<void> _goToTheDirectLocation() async {
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() async {
        position = currloc;

        final GoogleMapController controller = await _controller.future;
        CameraPosition x = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(currloc.latitude, currloc.longitude),
          zoom: 19.151926040649414,
        );
        controller.animateCamera(CameraUpdate.newCameraPosition(x));
        setState(() {
          final marker = Marker(
            markerId: MarkerId("1"), //37.43296265331129, -122.08832357078792
            position: LatLng(currloc.latitude, currloc.longitude),
            infoWindow: InfoWindow(
              title: "subhi home",
              snippet: "addressssss",
            ),
          );
          _markers['11'] = marker;
        });
      });
    });
  }
}
