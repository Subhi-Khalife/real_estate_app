part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class GetAllCountry extends CountryEvent{
  @override
  List<Object> get props => [];
}
