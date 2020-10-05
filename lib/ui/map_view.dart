import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Provider/google_map_provider.dart';
import 'package:real_estate_app/Provider/provier_property.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/model/filter_model.dart';
import 'package:real_estate_app/ui/add_properity/add_property_spec_and_image.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/ui/house_details/house_details_view.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';

import 'house_details/house_details_param.dart';

class MapView extends StatefulWidget {
  @override
  _MapView createState() => _MapView();
}

class _MapView extends State<MapView> {
  Set<Circle> circles;
  Set<Polyline> _polyline;
  PolylinePoints polylinePoints = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
            print("Loading Map Info State ");
            return loadingInfo();
          } else if (state is SetHouseValuesState) {
            print("Map Info State Loaded Finally ");
            setMarkers(state.types.properties);
            return showGoogleMap();
          } else if (state is SetHouseValuesFilter) {
            print("Map From Filter Info State Loaded Finally ");
            setMarkers(state.types.properties);
            return showGoogleMap();
          } else if (state is ErrorState) {
            print("Errors Into Get State Google Map Info");
            return error();
          }
          print("Errors Into Get State Google Map Info");
          return error();
        },
      ),
      floatingActionButton: floatingActionButtomView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  Widget floatingActionButtomView() {
    return Row(
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
    );
  }

  void setMarkers(Properties properties) {
    int length = properties.data.length;
    for (int i = 0; i < length; i++) {
      if (properties.data[i].longitude != null &&
          properties.data[i].latitude != null) {
        final marker = Marker(
          onTap: () {
            Property property = properties.data[i];
            HouseDetails houseDetails = HouseDetails(
              location: "property.area.cityName",
              isFavourit: property.isFavorite,
              areaCityAddress: property.area.cityName,
              areaCityName: property.area.name,
              phone: property.user.phone,
              email: property.user.email,
              description: property.description,
              price: property.price.toString(),
              image: property.img,
              property: property,
              properityId: property.id.toString(),
            );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HouesDetailFavourits(
                houseDetails: houseDetails,
              ),
            ));
          },
          markerId: MarkerId(properties.data[i].id.toString()),
          position: LatLng(
            properties.data[i].latitude,
            (properties.data[i].longitude),
          ),
        );
        googleMapProvider.addToMarker(marker);
      }
    }
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
