part of 'explore_dart_bloc.dart';

@immutable
abstract class ExploreDartEvent extends Equatable {}

class LoadingExploreData extends ExploreDartEvent {
  BuildContext context;
  LoadingExploreData(this.context);
  @override
  List<Object> get props => [context];
}

class ChangeValuesEvent extends ExploreDartEvent {
  Data items;
  ChangeValuesEvent({this.items});
  @override
  List<Object> get props => [items];
}
