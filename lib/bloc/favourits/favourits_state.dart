part of 'favourits_bloc.dart';

abstract class FavouritsState extends Equatable {
  const FavouritsState();
}

class FavouritsInitial extends FavouritsState {
  @override
  List<Object> get props => [];
}

class ErrorFavState extends FavouritsState {
  @override
  List<Object> get props => [];
}

class LoadingFavDataState extends FavouritsState {
  @override
  List<Object> get props => [];
}

class GetAllFavouritsState extends FavouritsState {
  GetAllFavouritesModel datum;
  GetAllFavouritsState({this.datum});
  @override
  List<Object> get props => [datum];
}
