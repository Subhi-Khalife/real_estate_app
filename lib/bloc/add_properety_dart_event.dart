part of 'add_properety_dart_bloc.dart';

@immutable
abstract class AddProperetyDartEvent extends Equatable{

}

class LoadingData extends AddProperetyDartEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ShowSpecEvent extends AddProperetyDartEvent{
  int index;
  GetAllTypeApi getAllTypeApi;
  ShowSpecEvent(this.index,this.getAllTypeApi);
  @override
  // TODO: implement props
  List<Object> get props => [index];
}