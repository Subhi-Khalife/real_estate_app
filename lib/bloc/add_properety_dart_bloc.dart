import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estate_app/Api/add_property_api.dart';
import 'package:real_estate_app/model/country_model.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
part 'add_properety_dart_event.dart';
part 'add_properety_dart_state.dart';

class AddProperetyDartBloc extends Bloc<AddProperetyDartEvent, AddProperetyDartState> {
  AddProperetyDartBloc() : super(AddProperetyDartInitial());

  @override
  Stream<AddProperetyDartState> mapEventToState(
      AddProperetyDartEvent event) async* {
    if (event is LoadingData) {
      yield Wait();
      try {
        print("the status :: ");

        GetAllTypeApi items = await AddPropertyApi.getAllProperty();
        print("the status :: ${items.status}");
        print("yessss");
        print("the length is :: ${items.data.length}");
        print("the length33 is :: ${items.data[1].typeSpecs.length}");

        for(int i=0;i<6;i++){
          print("the name");
          print("${items.data[1].typeSpecs[i].name}");
          print("the length ${items.data[1].typeSpecs[i].typeOptions.length}");

        }
        if(items.status!="no")
        yield InsertAllPropertyType(items, -1);
        else
          yield Error();

      } catch (e) {
        print("error happened");
        yield Error();
      }
    } else if (event is ShowSpecEvent) {
      yield Wait();
      try {
        yield InsertAllPropertyType(event.getAllTypeApi, event.index);
      } catch (e) {
        print("error happened");
        yield Error();
      }
    }
    else if(event is UpdateInfoEvent){
      yield InsertAllPropertyType(event.getAllTypeApi, event.index);
    }
  }

  @override
  void onTransition(Transition<AddProperetyDartEvent, AddProperetyDartState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
}
