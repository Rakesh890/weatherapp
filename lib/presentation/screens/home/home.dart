import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/core/constants/api.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';
import 'package:weatherapp/injectors/injector.dart';
import 'package:weatherapp/presentation/blocs/home/home_bloc.dart';
import 'package:weatherapp/utils/colors.dart';

import '../../widgets/WeatherInfo.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeBloc = serviceLocator<HomeBloc>();
  var lat, log;
  double width = 0.0;
  double height = 0.0;
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeBloc.add(FetchCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          title: SearchBar(
            onSubmitted: (val){
              final cityName = val.toString();
              homeBloc.add(FetchWeatherAccordingToCityWise(url: Api.searchWeatherUrl+val));
            },
            onChanged: (val){
              final cityName = val.toString();
              if(cityName.isEmpty){
                homeBloc.add(FeatchWeatherDataEvent(url:  "${Api.currentWeatherUrl}&lat=${homeBloc.currentPosition!.latitude}&lon=${homeBloc.currentPosition!.longitude}"));
              }
            },
            shape:MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            elevation: MaterialStateProperty.all(
              0.0
            ),
            leading: const Icon(Icons.search),
            hintText: "City Name",
            controller:searchTextEditingController,
          ),
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: homeBloc,
          builder: (context, state) {
            if (state is GotCurrentLocation) {
              ///Receive current location will call fetch weather data according to lat and long
              homeBloc.add(FeatchWeatherDataEvent(url:  "${Api.currentWeatherUrl}&lat=${state.currentPosition!.latitude}&lon=${state.currentPosition!.longitude}"));
            } else if (state is HomeWeatherDataLoaded) {
              return WeatherInfoView(
                weatherModelEntity:state.weatherModelEntity,
                address:state.address
              );
            } else if (state is HomeFetchCurrentLoction ||
                state is FetchForcastingDataEvent) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildWeatherBindDataView(WeatherModelEntity weatherModelEntity,
      String address, dynamic forcastingReponse) {
    final List<dynamic> list = forcastingReponse['list'];
    debugPrint(list.toString());
    final weaterItems = weatherModelEntity.weather![0];
    debugPrint(weaterItems.main.toString());
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
          Text(address.toString(),
          style: const TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontSize: 16.0),),

          // Expanded(
          //   child: buildForcasting(list),
          // )
        ]),
      ),
    );
  }

  buidlWeatherImage(String? icon) {
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
