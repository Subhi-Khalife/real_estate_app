import 'package:flutter/cupertino.dart';
import 'package:real_estate_app/model/filter_model.dart';
import 'package:real_estate_app/ui/add_properity/required_param.dart';

class FilterProvider extends ChangeNotifier {
  // List<Data> filtersValues = List<Data>();

  RequiredParam requiredParam;

  bool _isShowFilter = false;


  bool get isShowFilter => _isShowFilter;


  setIsShowFilter(bool value) {
    _isShowFilter = value;
    notifyListeners();
  }

  initValues() {
    requiredParam = RequiredParam();
  }

  setChangeBottomSheetValues() {
    notifyListeners();
  }

  setFirstTime(bool values) {
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
