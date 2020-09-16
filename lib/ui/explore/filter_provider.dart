import 'package:flutter/cupertino.dart';
import 'package:real_estate_app/model/filter_model.dart';

class FilterProvider extends ChangeNotifier {
  // List<Data> filtersValues = List<Data>();
  bool firstTime;
  initValues() {
    // filtersValues = List<Data>();
    firstTime=false;
  }
  setFirstTime(bool values){
    firstTime=true;
    notifyListeners();
  }

  setFirstValues(bool values) {
    notifyListeners();
  }

  setNewFilter(Data newFilter) {
    // filtersValues.add(newFilter);
    notifyListeners();
  }

  deleteItem() {
    // filtersValues.removeLast();
    notifyListeners();
  }

  // List<Data> get getFiltersArray => filtersValues;
}
