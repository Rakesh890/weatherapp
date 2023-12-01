import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/error/app_exceptions.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<WeatherModelEntity, AppException>> fetchCurrentWeather(
      {required String url});

  Future<Either<dynamic, AppException>> fetchForcastingWeather(
      {required String url});

  Future<Either<dynamic, AppException>> searchWeather(
      {required String url});
}
