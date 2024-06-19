// import 'package:clima_exito/infraestructure/models/openweather/openweather_response.dart';

class WeatherData {
  // final Coord coord;

  final int idWeather;
  final String mainWeather;
  final String descriptionWeather;
  final String iconWeather;
  final String base;
  final double temperature;
  final int humidity;
  final int visibility;
  final int clouds;
  final int dt;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  final double windSpeed;
  final int windDeg;
  final double windGust;

  WeatherData({
    required this.idWeather,
    required this.mainWeather,
    required this.descriptionWeather,
    required this.iconWeather,
    required this.windDeg,
    required this.windSpeed,
    required this.windGust,
    required this.base,
    required this.temperature,
    required this.humidity,
    required this.visibility,
    required this.clouds,
    required this.dt,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });
}
