import 'package:flutter/cupertino.dart';
import 'package:real_estate_app/model/filter_model.dart';

class HousesCategoryProvider extends ChangeNotifier {
  Map<String, List<Datum>> items = {};
  var list;


  resetMapValues() {
    items.clear();
    notifyListeners();
  }

  addValues(Data filterModel) {
    items.clear();
    for (int i = 0; i < filterModel.properties.data.length; i++) {
      if (items[filterModel.properties.data[i].type.name] == null) {
        print("ok inside MAP");
        items[filterModel.properties.data[i].type.name] = List<Datum>();
      }
      items[filterModel.properties.data[i].type.name]
          .add(filterModel.properties.data[i]);
    }
    print("the Map length is :: ${items.length}");
    list = items.values.toList();
    for (int i = 0; i < list.length; i++) {
      print("the length of length is :: ${list[i].length}");
    }
    notifyListeners();
  }
}
