part of 'explore_dart_bloc.dart';

@immutable
abstract class ExploreDartState extends Equatable{}

class ExploreDartInitial extends ExploreDartState {
  @override
  List<Object> get props => [];
}


class LoadingState extends ExploreDartState {
  @override
  List<Object> get props => [];
}

class SetHouseValuesFilter extends ExploreDartState{
  Data types;
  int index;
  SetHouseValuesFilter({this.types,this.index});
  @override
  List<Object> get props => [types,index];
}

class SetHouseValuesState extends ExploreDartState{
  Data types;
  int index;
  SetHouseValuesState({this.types,this.index});
  @override
  List<Object> get props => [types,index];
}

class ErrorState extends ExploreDartState{

  @override
  List<Object> get props => [];
}