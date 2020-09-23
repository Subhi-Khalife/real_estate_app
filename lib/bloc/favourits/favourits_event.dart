part of 'favourits_bloc.dart';

abstract class FavouritsEvent extends Equatable {
  const FavouritsEvent();
}

class GetAllFavouritEvent extends FavouritsEvent{
  @override
  List<Object> get props => [];

}