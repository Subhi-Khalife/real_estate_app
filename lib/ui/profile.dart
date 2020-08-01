import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'file:///D:/404Developers/real_estate_app/lib/ui/add_properity/add_property_spec_and_image.dart';
import 'package:real_estate_app/widget/color_app.dart';

class ProfileView extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ProfileView> {
  LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
  LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);
  Set<Circle> circles;
  Set<Polyline> _polyline;
  PolylinePoints polylinePoints = PolylinePoints();
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
    _polyline = Set<Polyline>();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        onTap: (x) {
          print(x);
          print("Sadsadas");
        },
        circles: circles,
        polylines: _polyline,
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
            offset: Offset(3, 8),
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

//  void set() async {
//    List<LatLng> latlng = List();
//
//    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//        "AIzaSyByVFzmF91NWH2gcvkE4hGgqK5Rl_cBVRE",
//        PointLatLng(36.22635162756718, 37.14083556085825),
//        PointLatLng(36.22413325507572, 37.143884897232056),
//        travelMode: TravelMode.driving,
//        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
//    if (result.points.isNotEmpty) {
//      result.points.forEach((PointLatLng point) {
//        latlng.add(LatLng(point.latitude, point.longitude));
//      });
//    }
//
//    setState(() {
//      _polyline.add(Polyline(
//        polylineId: PolylineId("1"),
//        visible: true,
//        //latlng is List<LatLng>
//        points: latlng,
//        color: Colors.blue,
//      ));
//    });
//    setState(() {});
//  }

  void set() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddPropertySpecAndImage()));
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
          circles = Set.from([
            Circle(
              visible: true,
              circleId: CircleId("id"),
              fillColor: Colors.green.withOpacity(0.3),
              zIndex: 3,
              strokeColor: Colors.green.withOpacity(0.3),
              consumeTapEvents: true,
              onTap: () {
                print("test");
              },
              strokeWidth: 0,
              center: LatLng(currloc.latitude, currloc.longitude),
              radius: 20,
            )
          ]);

          final marker = Marker(
            onTap: () {
              print("test");
            },
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
