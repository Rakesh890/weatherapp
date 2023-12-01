import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/domain/entites/weather_entity.dart';

class WeatherInfoView extends StatelessWidget {
  final WeatherModelEntity weatherModelEntity;
  final String? address;
  const WeatherInfoView({Key? key,required this.weatherModelEntity,required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("https://openweathermap.org/img/wn/${weatherModelEntity.weather!.first.icon}@4x.png");
    return  Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
             ListTile(
               leading: const Icon(Icons.place_outlined,color: Colors.white,size: 32,),
               title: Text(address!,style: const TextStyle(
                 fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500
               ),),
             ),
              const Divider(),
              FadeInImage.assetNetwork(placeholder: "", image: "https://openweathermap.org/img/wn/${weatherModelEntity.weather!.first.icon}@4x.png",),
              const SizedBox(height: 10,),
              Text(weatherModelEntity.weather!.first.main!,style: const TextStyle(
                  fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 10,),
              buildRow(iconColors: Colors.white,
                  iconType: Icons.wind_power,
                  value: weatherModelEntity.wind!.speed.toString()),
              const SizedBox(height: 10,),
             buildRow(iconColors: Colors.red,
             iconType: Icons.thermostat,
             value: weatherModelEntity.main!.temp.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Row buildRow({required IconData iconType,required Color iconColors, required String value}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(iconType,color: iconColors,size: 32,),
             Text(value.toString(),style: const TextStyle(
                 fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500
             ),),
           ],
         );
  }




}
