import 'package:get_it/get_it.dart';
import 'package:weatherapp/data/data_source/network/network/api_service.dart';
import 'package:weatherapp/data/reporitory_impl/weather_repoistory_impl.dart';
import 'package:weatherapp/domain/usecase/weather_usecase.dart';
import 'package:weatherapp/presentation/blocs/home/home_bloc.dart';
import '../domain/repository/weather_repository.dart';

final serviceLocator = GetIt.instance;

void initDepInject() {
  //Todo Bloc service
  serviceLocator.registerLazySingleton<HomeBloc>(
      () => HomeBloc(weatherUseCase: serviceLocator()));

  serviceLocator.registerFactory<WeatherRepository>(
      () => WeatherRepositoryImplementation(apiServices: serviceLocator()));

  //Todo Use Case (domain layer)
  serviceLocator.registerFactory(
      () => WeatherUseCase(weatherRepository: serviceLocator()));

  //Todo  Service
  serviceLocator.registerFactory<ApiServices>(() => ApiServices());
}
