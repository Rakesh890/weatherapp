import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/error/app_exceptions.dart';
import 'package:weatherapp/data/reporitory_impl/weather_repoistory_impl.dart';
import 'package:weatherapp/domain/repository/weather_repository.dart';

import '../entites/weather_entity.dart';

class WeatherUseCase {
  final WeatherRepository weatherRepository;
  WeatherUseCase({required this.weatherRepository});

  Future<Either<WeatherModelEntity, AppException>> fetchWeather(
      {required String url}) async {
    final response = await weatherRepository.fetchCurrentWeather(url: url);
    return response;
  }

  Future<Either<dynamic, AppException>> fetchForcastingWeather(
      {required String url}) async {
    final response = await weatherRepository.fetchForcastingWeather(url: url);
    return response;
  }

  Future<Either<dynamic, AppException>> searchWeather(
      {required String url}) async {
    final response = await weatherRepository.searchWeather(url: url);
    return response;
  }
}
