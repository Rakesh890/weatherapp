import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/core/api.dart';
import 'package:weatherapp/data/data_source/network/api_service.dart';
import 'package:weatherapp/data/reporitory_impl/weather_repoistory_impl.dart';
import 'package:weatherapp/domain/usecase/weather_usecase.dart';
import 'package:weatherapp/injectors/injector.dart';

class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _currentAddress;
  Position? _currentPosition;

   WeatherUseCase weatherUseCase = WeatherUseCase(weatherRepositoryImplementation: WeatherRepositoryImplementation(apiProvider: ApiServices()));


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () => getCurrentLocation(),
            child: const Text("Current Locatuions")),
        Text(_currentPosition.toString())
      ]),
    );
  }

  void getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      getCurrentLiveWeater(position);
      debugPrint("Current lat${_currentPosition!..altitude}");
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentLiveWeater(Position position) async {
    final weatherData = await weatherUseCase.fetchWeather(url: "${Api.currentWeatherUrl}&lat=${position.latitude}&lon=${position.longitude}");
    weatherData.fold((value) {
      debugPrint("Current Weather Data $value");
    }, (err) => debugPrint("something went wrong $err"));
  }
}
