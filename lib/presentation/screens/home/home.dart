import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/api.dart';
import 'package:weatherapp/data/data_source/network/network/api_service.dart';
import 'package:weatherapp/data/reporitory_impl/weather_repoistory_impl.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';
import 'package:weatherapp/domain/usecase/weather_usecase.dart';
import 'package:weatherapp/injectors/injector.dart';
import 'package:weatherapp/presentation/blocs/home/home_bloc.dart';
import 'package:weatherapp/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = serviceLocator<HomeBloc>();
  var lat, log;
  double width = 0.0;
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    homeBloc.add(FetchCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is GotCurrentLocation) {
            final url =
                "${Api.currentWeatherUrl}&lat=${state.currentPosition!.latitude}&lon=${state.currentPosition!.latitude}";
            final forcastUrl =
                "${Api.forcastingWeatherUrl}&lat=${state.currentPosition!.latitude}&lon=${state.currentPosition!.latitude}";
            homeBloc
              ..add(GetWeatherDataEvent(url: url))
              ..add(FetchForcastingDataEvent(url: forcastUrl));

            return const SizedBox();
          } else if (state is HomeWeatherDataLoaded) {
            return SizedBox(
                width: width,
                height: height,
                child: buildWeatherBindDataView(state.weatherModelEntity,
                    state.address ?? "", state.forcastingReponse));
          } else if (state is HomeFetchCurrentLoction ||
              state is FetchForcastingDataEvent) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(child: Text("something went wrong ${state}"));
          }
        },
      ),
    );
  }

  Widget buildWeatherBindDataView(WeatherModelEntity weatherModelEntity,
      String address, dynamic forcastingReponse) {
    final List<dynamic> list = forcastingReponse['list'];
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          homeBloc.add(FetchCurrentLocationEvent());
        },
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(children: [
              Text(address.toString()),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  final weaterItems = weatherModelEntity.weather![index];
                  return Column(
                    children: [
                      Text.rich(TextSpan(
                          text: "${weaterItems.main}",
                          style: const TextStyle(
                              fontFamily: "Roboto",
                              color: AppColors.kPrimaryColor,
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "(${weaterItems.description})",
                              style: const TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.purple,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ])),
                      buidlWeatherImage(weaterItems.icon),
                    ],
                  );
                },
                itemCount: weatherModelEntity.weather!.length,
              ),
              Expanded(
                child: buildForcasting(list),
              )
            ]),
          ),
        ),
      ),
    );
  }

  buidlWeatherImage(String? icon) {
    return Image.network(
      "https://openweathermap.org/img/wn/$icon@4x.png",
    );
  }

  buildForcasting(List list) {
    return PageView.builder(
      allowImplicitScrolling: true,
      itemBuilder: (context, int index) {
        List<dynamic> weatherList = list[index]['weather'];
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 5),
          child: Card(
            color: Colors.white.withOpacity(0.01),
            child: Column(
              children: [
                Text("Wind Speed : ${list[index]['wind']["speed"]}"),
                Text(
                    "Date : ${DateFormat.yMMMd().format(DateTime.parse(list[index]['dt_txt']))}"),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: weatherList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(weatherList[0]['main']),
                        Text(weatherList[0]['description']),
                        buidlWeatherImage(weatherList[0]['icon'])
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      itemCount: list.length,
    );
  }
}
