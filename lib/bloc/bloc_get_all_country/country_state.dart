part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();
}

class CountryInitial extends CountryState {
  @override
  List<Object> get props => [];
}
class Loading extends CountryState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchAllCountry extends CountryState {
  CountryModel countryModel;
  FetchAllCountry(this.countryModel);
  @override
  List<Object> get props => [countryModel];
}
class FailedGetAllCountries extends CountryState{
  @override
  List<Object> get props => [];

}

class CatchError extends CountryState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}