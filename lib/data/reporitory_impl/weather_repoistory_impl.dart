import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:weatherapp/core/app_exceptions.dart';
import 'package:weatherapp/data/data_source/network/network/api_service.dart';
import 'package:weatherapp/data/models/weater_model.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';
import 'package:weatherapp/domain/repository/weather_repository.dart';

class WeatherRepositoryImplementation extends WeatherRepository {
  final ApiServices apiServices;

  WeatherRepositoryImplementation({required this.apiServices});

  @override
  Future<Either<WeatherModelEntity, AppException>> fetchCurrentWeather(
      {required String url}) async {
    try {
      final result = await apiServices.executeGet(url: url);
      switch (result!.statusCode) {
        case 200:
          final data = json.decode(result.body);
          return left(WeaterModel.fromJson(data));
        case 404:
          return right(BadRequestException());
        case 401:
          return right(UnauthorisedException());
        case 500:
          return right(InternalServerError());
        default:
          return right(GeneralException());
      }
    } on SocketException catch (_) {
      return right(FetchDataException());
    } catch (err) {
      return right(GeneralException());
    }
  }

  @override
  Future<Either<dynamic, AppException>> fetchForcastingWeather(
      {required String url}) async {
    try {
      final result = await apiServices.executeGet(url: url);
      debugPrint(url);
      switch (result!.statusCode) {
        case 200:
          final data = json.decode(result.body);
          debugPrint("Response ${data['list']}");
          return left(data);
        case 404:
          return right(BadRequestException());
        case 401:
          return right(UnauthorisedException());
        case 500:
          return right(InternalServerError());
        default:
          return right(GeneralException());
      }
    } on SocketException catch (_) {
      return right(FetchDataException());
    } catch (err) {
      return right(GeneralException());
    }
  }
}
