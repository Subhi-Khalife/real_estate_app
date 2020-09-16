import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/add_properity/spec_values.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/ui/explore/spec_value_for_filter.dart';

class RequiredParam
{
  List<SpecValuesForFilter>specValuesForFilter=List<SpecValuesForFilter>();
  TextEditingController minPrice=TextEditingController();
  TextEditingController maxPrice=TextEditingController();
  TextEditingController minSpace=TextEditingController();
  TextEditingController maxSpace=TextEditingController();
//////////////////////////////////////////////////////////////////////////
  List<String> propertyImages = [];
  List<int> typeId = [];
  List<String> first = [];
  List<TextEditingController> controller = [];
  TextEditingController proprtyController = TextEditingController();
  int randomValueCard = 100;
  int select;
  List<int> houseIndex = [];
  List<String> collapse = List();
  Map<int, List<int>> specID = {};
  List<SpecValues> specValues = [];
///////////////////////////////////////////////////
  ValueNotifier<bool> isVal = ValueNotifier<bool>(false);
  ValueNotifier<bool> useTypeVal = ValueNotifier<bool>(false);
  ValueNotifier<Color> colorTextCountry = ValueNotifier<Color>(Colors.black);
  ValueNotifier<Color> colorTextUseType = ValueNotifier<Color>(Colors.black);
  ValueNotifier<String> title = ValueNotifier<String>("* اختر المنطقة");
  ValueNotifier<String> useTypeTitle = ValueNotifier<String>("* نوع العقار");
  List<String> useTypes = ["إيجار","بيع","رهن"];
  String useTypeValue;
  int areaId = 0;
  String address ="";
  TextEditingController spaceController =TextEditingController();
  TextEditingController postalCodeController =TextEditingController();
  TextEditingController priceController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  FocusNode priceNode =FocusNode();
  FocusNode spaceNode =FocusNode();
  FocusNode postalCodeNode =FocusNode();

  //////////////////////////////////////////
  Completer<GoogleMapController> mapController = Completer();
  MarkerId selectedMarker;
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(36.2021, 37.1343),
    zoom: 13.4746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  int markerIdCounter = 1;


  bool isLocationEnable = false;
  MapType mapType ;

  RequiredParam() {
    typeId.add(-1);
    houseIndex.add(-1);
    first.add("نوع العقار");
    proprtyController.text = "";
    for (int i = 0; i < 70; i++) {
      controller.add(TextEditingController());
      collapse.add("");
      specID[i] = [];
    }
  }

  @override
  String toString() {
    return 'RequiredParam{propertyImages: $propertyImages, typeId: $typeId, first: $first, randomValueCard: $randomValueCard, select: $select, houseIndex: $houseIndex, collapse: $collapse, specID: $specID, specValues: $specValues, colorTextCountry: $colorTextCountry, title: $title, useTypeTitle: $useTypeTitle, useTypes: $useTypes, useTypeValue: $useTypeValue, areaId: $areaId, address: $address, markerIdCounter: $markerIdCounter, mapType: $mapType}';
  }
}
