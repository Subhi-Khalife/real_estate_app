import 'package:flutter/cupertino.dart';
import 'package:real_estate_app/ui/add_properity/spec_values.dart';

class RequiredParam {
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
}
