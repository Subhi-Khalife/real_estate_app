part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class getAllDataState extends NewsState{
  Data data;
  getAllDataState({this.data});
  @override
  List<Object> get props => [];
}

class LoadingDataState extends NewsState{
  @override
  List<Object> get props =>[];
}

class  ErrorDataState extends NewsState{
  @override
  List<Object> get props => [];

}