import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/app_exceptions.dart';
import 'package:weatherapp/data/data_source/network/api_service.dart';
import 'package:weatherapp/data/models/weater_model.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';
import 'package:weatherapp/domain/repository/weather_repository.dart';

class WeatherRepositoryImplementation with WeatherRepository{

  final ApiServices apiProvider;

  WeatherRepositoryImplementation({required this.apiProvider});

  @override
  Future<Either<WeaterModelEntity, AppException>> fetchCurrentWeather({required String url}) async {
    try {
      final result = await apiProvider.executeGet(url: url);
      switch (result!.statusCode) {
        case 200:
          final data = json.decode(result.body);
          return left(WeaterModel.fromJson(data));
        case 404:
          throw right(BadRequestException());
        case 401:
          throw right(UnauthorisedException());
        case 500:
          throw right(InternalServerError());
        default:
          throw right(GeneralException());
      }
    } on SocketException catch (_) {
      throw FetchDataException();
    } catch (err) {
      throw GeneralException();
    }
  }

}