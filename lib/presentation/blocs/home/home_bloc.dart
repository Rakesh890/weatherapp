import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/core/error/app_exceptions.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';
import 'package:weatherapp/domain/usecase/weather_usecase.dart';
import 'package:weatherapp/injectors/injector.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  WeatherUseCase weatherUseCase;
  Position? currentPosition;
  late WeatherModelEntity weatherModelEntity;
  late String address;

  HomeBloc({required this.weatherUseCase}) : super(HomeFetchCurrentLoction()) {
    on<FetchCurrentLocationEvent>(fetchCurrentLocation);
    on<FeatchWeatherDataEvent>(fetchWeatherData);
    on<FetchForcastingDataEvent>(fetchForcastingData);
    on<FetchWeatherAccordingToCityWise>(featchWeatherAccordingToCity);
  }

  //Get current location of user
  FutureOr<void> fetchCurrentLocation(
      FetchCurrentLocationEvent event, Emitter<HomeState> emit) async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;
      await getAddressFromCoordinates(
          latitude: position.latitude.toDouble(),
          longitude: position.longitude.toDouble(),
          emit: emit);
      emit(GotCurrentLocation(currentPosition: currentPosition, address: address));
    }).catchError((e) {
      emit(UnableToGetLocation(error: e));
    });
  }

  //Get weather data according to current location
  FutureOr<void> fetchWeatherData(
      FeatchWeatherDataEvent event, Emitter<HomeState> emit) async {
    final result = await weatherUseCase.fetchWeather(url: event.url);
    result.fold((value) {
      weatherModelEntity = value;
      emit(HomeWeatherDataLoaded(
          weatherModelEntity: weatherModelEntity,
          address: address));
    }, (err) {
      final AppException appException = err;
      debugPrint("data err $err");
      emit(HomeWeatherFailure(appException: appException));
    });
  }

  Future<void> getAddressFromCoordinates(
      {required double latitude,
      required double longitude,
      required Emitter<HomeState> emit}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        address = "${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}";
      }
    } catch (e) {
      throw "Error retrieving address";
    }
  }

  //Permission
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  FutureOr<void> fetchForcastingData(
      FetchForcastingDataEvent event, Emitter<HomeState> emit) async {
    final result = await weatherUseCase.fetchForcastingWeather(url: event.url);
    result.fold((value) async {
      emit(GotForcastingData(
        forcastingResponse: value,
      ));
    }, (err) {
      final AppException appException = err;
      emit(ErorrForcasrting(error: appException));
    });
  }

  FutureOr<void> featchWeatherAccordingToCity(FetchWeatherAccordingToCityWise event, Emitter<HomeState> emit) async {
    final result = await weatherUseCase.fetchForcastingWeather(url: event.url);
    result.fold((value) async {
      emit(GotSearchWeatherData(
        response: value,
      ));
    }, (err) {
      final AppException appException = err;
      emit(ErorrForcasrting(error: appException));
    });
  }
}
