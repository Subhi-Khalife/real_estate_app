import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate_app/Api/favourite.dart';
import 'package:real_estate_app/model/get_all_favourites_model.dart';

part 'favourits_event.dart';
part 'favourits_state.dart';

class FavouritsBloc extends Bloc<FavouritsEvent, FavouritsState> {
  FavouritsBloc() : super(FavouritsInitial());

  @override
  Stream<FavouritsState> mapEventToState(FavouritsEvent event) async* {
    if (event is GetAllFavouritEvent) {
      yield LoadingFavDataState();
      try {
        GetAllFavouritesModel getAllFavouritesModel =await FavouriteApi.getAllFavourites();
        yield GetAllFavouritsState(datum:getAllFavouritesModel );
      } catch (e) {
        yield ErrorFavState();
      }
    }
  }
}
