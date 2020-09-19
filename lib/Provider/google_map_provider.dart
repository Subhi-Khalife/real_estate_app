import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapProvider extends ChangeNotifier {
  Set<Marker> marker = {};
  Set<Circle> circles={};


  addToMarker(Marker x) {
    marker.add(x);
    notifyListeners();
  }

  Set<Marker> getAllMarker() {
    return marker;
  }

  addToCircle(Circle x) {
    circles.add(x);
    notifyListeners();
  }
  Set<Circle>getAllCircle(){
    return circles;
  }
}
/*
circles =
 */