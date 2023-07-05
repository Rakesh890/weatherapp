part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeWeatherDataLoaded extends HomeState {
  final WeatherModelEntity weatherModelEntity;
  final String? address;
  final dynamic forcastingReponse;
  HomeWeatherDataLoaded(
      {required this.weatherModelEntity,
      this.address,
      required this.forcastingReponse});
}

class HomeWeatherFailure extends HomeState {
  final AppException appException;
  HomeWeatherFailure({required this.appException});
}

class HomeFetchCurrentLoction extends HomeState {}

class UnableToGetLocation extends HomeState {
  dynamic error;
  UnableToGetLocation({required this.error});
}

class LoadingFocastingData extends HomeState {}

class GotForcastingData extends HomeState {
  var forcastingResponse;
  GotForcastingData({required this.forcastingResponse});
}

class ErorrForcasrting extends HomeState {
  dynamic error;
  ErorrForcasrting({required this.error});
}

class GotCurrentLocation extends HomeState {
  Position? currentPosition;
  String address;
  GotCurrentLocation({required this.currentPosition, required this.address});
}
