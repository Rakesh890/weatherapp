

import 'package:get_it/get_it.dart';
import 'package:weatherapp/data/data_source/network/api_service.dart';
import 'package:weatherapp/data/reporitory_impl/weather_repoistory_impl.dart';
import 'package:weatherapp/domain/usecase/weather_usecase.dart';
import 'package:weatherapp/presentation/screens/home/home.dart';

import '../domain/repository/weather_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDepInject() async {
  //Todo Bloc service

  //Todo Use Case (domain layer)
  serviceLocator.registerFactory(
          () => WeatherUseCase(weatherRepositoryImplementation: serviceLocator()));
  //Todo Repository Impl
  serviceLocator.registerFactory<WeatherRepository>(() => WeatherRepositoryImplementation(apiProvider: serviceLocator()));

  //Todo  Service
  serviceLocator.registerFactory<ApiServices>(() => ApiServices());
}
