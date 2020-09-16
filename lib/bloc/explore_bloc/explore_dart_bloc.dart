import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:real_estate_app/Api/get_filter_api.dart';
import 'package:real_estate_app/model/filter_model.dart';
part 'explore_dart_event.dart';
part 'explore_dart_state.dart';

class ExploreDartBloc extends Bloc<ExploreDartEvent, ExploreDartState> {
  ExploreDartBloc() : super(ExploreDartInitial());

  @override
  Stream<ExploreDartState> mapEventToState(ExploreDartEvent event) async* {
    if (event is LoadingExploreData) {
      yield LoadingState();
      FilterModel values = await GetFilterApi.getFilter(getAllHouse: true);
      if (values.status == 'OK')
        yield SetHouseValuesState(types: values.data,index: -1);
      else
        yield ErrorState();
    }else if(event is ChangeValuesEvent){
      yield LoadingState();
      yield SetHouseValuesState(types: event.items,index: -1);
    }
  }
}
