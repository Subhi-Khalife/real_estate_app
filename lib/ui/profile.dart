import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Provider/google_map_provider.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/ui/add_properity/add_property_spec_and_image.dart';
import 'package:real_estate_app/ui/house_detail.dart';
import 'package:real_estate_app/widget/card_info.dart';
import 'file:///D:/projects/real_estate_app/lib/Provider/provier_property.dart';
import 'file:///D:/projects/real_estate_app/lib/Provider/filter_provider.dart';
import 'package:real_estate_app/widget/color_app.dart';

class ProfileView extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ProfileView> {
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
  MapType mapType = MapType.normal;
  GoogleMapProvider googleMapProvider;
  @override
  void initState() {
    super.initState();
    googleMapProvider = Provider.of<GoogleMapProvider>(context, listen: false);
    _polyline = Set<Polyline>();
  }

  PageController controller;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: BlocBuilder<ExploreDartBloc, ExploreDartState>(
          cubit: BlocProvider.of<ExploreDartBloc>(context),
          builder: (context, state) {
            if (state is LoadingState) {
              print("LoadingState LoadingState LoadingState ");

              return loadingInfo();
            } else if (state is SetHouseValuesState) {
              print("SetHouseValuesState");
              for (int i = 0; i < state.types.properties.data.length; i++) {
                if (state.types.properties.data[i].longitude != null &&
                    state.types.properties.data[i].latitude != null) {
                  final marker = Marker(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HouesDetail(
                          properties: state.types.properties.data[i],
                        )));

                      },
                      markerId: MarkerId(
                          state.types.properties.data[i].id.toString()),
                      position: LatLng(
                        state.types.properties.data[i].latitude,
                        (state.types.properties.data[i].longitude),
                      ));
                  googleMapProvider.addToMarker(marker);
                }
              }
              return showGoogleMap();
            } else if (state is ErrorState) {
              print("ERrors");
              return error();
            }
            print("ERROR2");
            return error();
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "alsjdhaslkdmas",
                  onPressed: () {
                    setState(() {
                      mapType = MapType.satellite;
                    });
                  },
                  backgroundColor: activeIconNavBar,
                  child: Icon(Icons.filter_hdr),
                  mini: true,
                ),
                SizedBox(
                  width: 5,
                ),
                FloatingActionButton(
                  heroTag: "aslkfcaslkm",
                  onPressed: () {
                    setState(() {
                      mapType = MapType.normal;
                    });
                  },
                  mini: true,
                  backgroundColor: activeIconNavBar,
                  child: Icon(Icons.satellite),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              // _filterProvider.firstTime = false;
              set();
            },
            backgroundColor: activeIconNavBar,
            heroTag: "salasnlkccadlkmdsa",
            child: Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  Widget error() {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        BlocProvider.of<ExploreDartBloc>(context)
          ..add(LoadingExploreData(context));
      },
    );
  }

  Widget loadingInfo() {
    return Center(child: CircularProgressIndicator());
  }

  Widget showGoogleMap() {
    return Consumer<GoogleMapProvider>(builder: (_, values, widget) {
      return GoogleMap(
        onTap: (x) {
          print(x);
          print("Sadsadas");
        },

        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        circles: values.getAllCircle(),
        polylines: _polyline,
        zoomControlsEnabled: false,
        mapToolbarEnabled: true,
        markers: values.getAllMarker(),
        mapType: mapType,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          print("inside onMapCreated");
          _goToTheDirectLocation();
          _controller.complete(controller);
        },
      );
    });
  }

  void set() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (context) => PropertyProvider(),
            child: AddPropertySpecAndImage())));
  }

  Future<void> _goToTheDirectLocation() async {
    print("inside Geolocator");
    Geolocator().getCurrentPosition().then((currloc) {
      print("inside Geolocator123");

      setState(() async {
        print("inside Geolocator345");

        position = currloc;
        print("the first ${position.longitude} %% ${position.latitude}");
        final GoogleMapController controller = await _controller.future;
        CameraPosition x = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(currloc.latitude, currloc.longitude),
          zoom: 19.151926040649414,
        );
        print("XX");
        controller.animateCamera(CameraUpdate.newCameraPosition(x));

      });
    });
  }
}
