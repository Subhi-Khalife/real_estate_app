import 'package:flutter/cupertino.dart';
import 'package:real_estate_app/model/filter_model.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';

class HousesCategoryProvider extends ChangeNotifier {
  Map<String, List<Property>> items = {};
  List<List<Property>> list;

  resetMapValues() {
    items.clear();
    notifyListeners();
  }

  addValues(Data filterModel) {
    items.clear();
    for (int i = 0; i < filterModel.properties.data.length; i++) {
      print("the id is  ::  ${filterModel.properties.data[i].id}");
      print("the type Name is :: ${filterModel.properties.data[i].type.name.toString()} ");
      if (items[filterModel.properties.data[i].type.name] == null) {
        print("the type Name is inside Map  :: ${items[filterModel.properties.data[i].type.name.toString()]} ");

        print("ok inside MAP");
        items[filterModel.properties.data[i].type.name] = List<Property>();
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
