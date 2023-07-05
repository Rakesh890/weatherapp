part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetWeatherDataEvent extends HomeEvent {
  final String url;
  GetWeatherDataEvent({required this.url});
}

class FetchCurrentLocationEvent extends HomeEvent {}

class FetchForcastingDataEvent extends HomeEvent {
  String url;
  FetchForcastingDataEvent({required this.url});
}
