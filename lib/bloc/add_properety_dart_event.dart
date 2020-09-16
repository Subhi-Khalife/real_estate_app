part of 'add_properety_dart_bloc.dart';

@immutable
abstract class AddProperetyDartEvent extends Equatable {}

class LoadingData extends AddProperetyDartEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ShowSpecEvent extends AddProperetyDartEvent {
  int index;
  GetAllTypeApi getAllTypeApi;
  ShowSpecEvent(this.index, this.getAllTypeApi);
  @override
  // TODO: implement props
  List<Object> get props => [index];
}

class UpdateInfoEvent extends AddProperetyDartEvent{
  int index;
  GetAllTypeApi getAllTypeApi;
  UpdateInfoEvent({this.index, this.getAllTypeApi});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}