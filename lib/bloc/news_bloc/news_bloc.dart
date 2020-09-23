import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/Api/get_filter_api.dart';
import 'package:real_estate_app/model/filter_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is GetAllNewsEvent) {
      yield LoadingDataState();

      FilterModel getAllNewsEvent = await GetFilterApi.getFilter(context: event.context,getAllHouse: true);

      try {
        if (getAllNewsEvent.status == "OK") {
          yield getAllDataState(data: getAllNewsEvent.data);
        } else {
          yield ErrorDataState();
        }
      } catch (e) {
        yield ErrorDataState();
      }
    }
  }
}
