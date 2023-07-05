import 'package:equatable/equatable.dart';


class WeatherModelEntity extends Equatable {
  final CoordEntity? coord;
  final List<WeatherEntity>? weather;
  final String? base;
  final MainEntity? main;
  final int? visibility;
  final WindEntity? wind;
  final CloudsEntity? clouds;
  final int? dt;
  final SysEntity? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  const WeatherModelEntity({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    coord,
    weather,
    base,
    main,
    visibility,
    wind,
    clouds,
    dt,
    sys,
    timezone,
    id,
    name,
    cod,
  ];

}

class CoordEntity extends Equatable{
  final double? lon;
  final double? lat;

  const CoordEntity({
    this.lon,
    this.lat,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    lon,
    lat,
  ];




}

class WeatherEntity extends Equatable {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherEntity({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    main,
    description,
    icon,
  ];


}

class MainEntity extends Equatable{
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  const MainEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    temp,
    feelsLike,
    tempMin,
    tempMax,
    pressure,
    humidity,
  ];



}

class WindEntity extends Equatable{
  final double? speed;
  final int? deg;
  final double? gust;

 const WindEntity({
    this.speed,
    this.deg,
    this.gust,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [ speed,
    deg,
    gust,];
}

class CloudsEntity extends Equatable{
  final int? all;

  const CloudsEntity({
    this.all,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [all];

}

class SysEntity extends Equatable{
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  const SysEntity({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    type,
    id,
    country,
    sunrise,
    sunset,
  ];
}