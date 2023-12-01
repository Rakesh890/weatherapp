class Api {
  static const String apiKey = '8878fb9ddad084f114801d2531230518';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String currentWeatherUrl = "${baseUrl}weather?appid=$apiKey";
  static const String forcastingWeatherUrl = "${baseUrl}forecast?appid=$apiKey";
  static const String searchWeatherUrl = "${baseUrl}weather?appid=$apiKey&q=";

}
