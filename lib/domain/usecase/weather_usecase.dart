import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/app_exceptions.dart';
import 'package:weatherapp/data/reporitory_impl/weather_repoistory_impl.dart';

import '../entites/weather_entity.dart';

class WeatherUseCase
{
  final WeatherRepositoryImplementation weatherRepositoryImplementation;

  WeatherUseCase({required this.weatherRepositoryImplementation});

  Future<Either<WeaterModelEntity,AppException>> fetchWeather({required String url})async {
    final response = await weatherRepositoryImplementation.fetchCurrentWeather(url: url);
    return response;
  }
}