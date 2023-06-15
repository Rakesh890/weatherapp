import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/app_exceptions.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';

mixin WeatherRepository{
  Future<Either<WeaterModelEntity,AppException>> fetchCurrentWeather({required String url});
}