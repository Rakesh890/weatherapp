import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/app_exceptions.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<WeatherModelEntity, AppException>> fetchCurrentWeather(
      {required String url});

  Future<Either<dynamic, AppException>> fetchForcastingWeather(
      {required String url});
}
