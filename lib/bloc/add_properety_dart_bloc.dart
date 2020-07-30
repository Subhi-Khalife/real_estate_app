import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estate_app/Api/add_property_api.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';

part 'add_properety_dart_event.dart';
part 'add_properety_dart_state.dart';

class AddProperetyDartBloc
    extends Bloc<AddProperetyDartEvent, AddProperetyDartState> {
  AddProperetyDartBloc() : super(AddProperetyDartInitial());

  @override
  Stream<AddProperetyDartState> mapEventToState(
      AddProperetyDartEvent event) async* {
    if (event is LoadingData) {
      yield Wait();
      try {
        GetAllTypeApi items = await AddPropertyApi.getAllProperty();
        yield InsertAllPropertyType(items, -1);
      } catch (e) {
        print("error happened");
      }
    } else if (event is ShowSpecEvent) {
      yield Wait();
      try {
        yield InsertAllPropertyType(event.getAllTypeApi, event.index);
      } catch (e) {}
    }
  }
}
