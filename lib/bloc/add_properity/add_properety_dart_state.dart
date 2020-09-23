part of 'add_properety_dart_bloc.dart';

@immutable
abstract class AddProperetyDartState extends Equatable {}

class AddProperetyDartInitial extends AddProperetyDartState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Wait extends AddProperetyDartState {
  @override
  List<Object> get props => [];
}

class InsertAllPropertyType extends AddProperetyDartState {
  GetAllTypeApi type;
  int index=0;
  InsertAllPropertyType(this.type,this.index);
  @override
  List<Object> get props => [type,index];
}

class Error extends AddProperetyDartState{
  @override
  List<Object> get props => [];

}

//class ShowTypeSpec extends AddProperetyDartState {
//  GetAllTypeApi type;
//  int houseIndex;
//  ShowTypeSpec(this.type, this.houseIndex);
//
//  @override
//  List<Object> get props => [type, houseIndex];
//}
