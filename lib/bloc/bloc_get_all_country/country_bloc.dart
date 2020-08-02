import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/Api/add_property_api.dart';
import 'package:real_estate_app/model/country_model.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  CountryBloc() : super(CountryInitial());

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if(event is GetAllCountry)
      yield* _mapGetAllCountryToState(event);

  }

  Stream<CountryState> _mapGetAllCountryToState(event) async*{
    yield Loading();
    try{
    CountryModel getAllCountries = await AddPropertyApi.getAllCountries();
    if(getAllCountries.status == "no internet")
    yield FailedGetAllCountries();
    if(getAllCountries.status == "OK")
    yield FetchAllCountry(getAllCountries);
    }catch(e){
      print("exception $e");
      yield CatchError();
    }

  }


}
