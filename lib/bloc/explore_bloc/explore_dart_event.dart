part of 'explore_dart_bloc.dart';

@immutable
abstract class ExploreDartEvent extends Equatable {}

class LoadingExploreData extends ExploreDartEvent {
  @override
  List<Object> get props => [];
}

class ChangeValuesEvent extends ExploreDartEvent {
  Data items;
  ChangeValuesEvent({this.items});
  @override
  List<Object> get props => [items];
}
