import 'package:flutter/cupertino.dart';

class PropertyProvider extends ChangeNotifier{
  String address = "";
  int areaId = 0;
  int price = 0;
  double space = 0;
  double longitude =0;
  double latitude = 0 ;
  double postalCode = 0;
  String useType = "";

  setAddressValue(String newAddress){
    address = newAddress ;
    notifyListeners();
  }

  setAreaIdValue(int newAreaId){
    areaId = newAreaId ;
    notifyListeners();
  }
  setPriceValue(int newPrice){
    price = newPrice ;
    notifyListeners();
  }
  setSpaceValue(double newSpace){
    space = newSpace ;
    notifyListeners();
  }
  setUseTypeValue(String newUseType){
    useType = newUseType ;
    notifyListeners();
  }
  setLongitudeValue(double newLongitude){
    longitude = newLongitude ;
    notifyListeners();
  }
  setLatitudeValue(double newLatitude){
    latitude = newLatitude ;
    notifyListeners();
  }
  setPostalCodeValue(double newPostalCode){
    postalCode = newPostalCode ;
    notifyListeners();
  }

  @override
  String toString() {
    return 'PropertyProvider{address: $address, areaId: $areaId, price: $price, space: $space, longitude: $longitude, latitude: $latitude, postalCode: $postalCode, useType: $useType}';
  }
}