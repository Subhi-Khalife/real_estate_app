part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}


class GetAllNewsEvent extends NewsEvent{
  BuildContext context;
  GetAllNewsEvent({this.context});
  @override
  List<Object> get props => [context];

}