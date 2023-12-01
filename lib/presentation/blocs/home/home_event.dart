part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FeatchWeatherDataEvent extends HomeEvent {
  final String url;
  FeatchWeatherDataEvent({required this.url});
}

class FetchCurrentLocationEvent extends HomeEvent {}

class FetchWeatherAccordingToCityWise extends HomeEvent {
  String url;
  FetchWeatherAccordingToCityWise({required this.url});
}


class FetchForcastingDataEvent extends HomeEvent {
  String url;
  FetchForcastingDataEvent({required this.url});
}
