import 'package:clima_exito/config/constants/environment.dart';
import 'package:clima_exito/domain/datasources/weather_datasource.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/domain/entities/weather_forecast.dart';
import 'package:clima_exito/infraestructure/mappers/forecast_mapper.dart';
import 'package:clima_exito/infraestructure/mappers/weather_mapper.dart';
import 'package:clima_exito/infraestructure/models/forecast/weather_forecast_response.dart';
import 'package:clima_exito/infraestructure/models/openweather/openweather_response.dart';
import 'package:dio/dio.dart';

class OpenweatherDatasourceImpl extends WeatherDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5/',
  ));

  @override
  Future<WeatherData> getCurrent({String lat = '0', String lon = '0'}) async {
    final response = await dio.get(
      'weather',
      queryParameters: {
        'appid': Environment.openWeatherKey,
        'lat': lat,
        'lon': lon,
        'units': 'metric',
      },
    );

    final openweatherResponse = OpenWeatherResponse.fromJson(response.data);
    final WeatherData weather =
        WeatherMapper.openWeatherToEntity(openweatherResponse);

    return weather;
  }

  @override
  Future<WeatherData> getByCity(String city) async {
    try {
      final response = await dio.get(
        'weather',
        queryParameters: {
          'appid': Environment.openWeatherKey,
          'q': city,
          'units': 'metric',
          'lat': '',
          'lon': '',
        },
      );


      final openweatherResponse = OpenWeatherResponse.fromJson(response.data);
      
      final WeatherData weather =
          WeatherMapper.openWeatherToEntity(openweatherResponse);

      return weather;
    } catch (e) {
      return WeatherData.defaultInstance();
    }
  }

  @override
  Future <List<WeatherForecast>> getTimeAndNextDays(
      {String lat = '', String lon = ''}) async {

      final response = await dio.get(
        'forecast',
        queryParameters: {
          'appid': Environment.openWeatherKey,
          'units': 'metric',
          'lat': lat,
          'lon': lon,
        },
      );

      final forecastWeatherResponse =
          WeatherForecastResponse.fromJson(response.data);


      final List<WeatherForecast> weatherDays = forecastWeatherResponse.list
      .map((toElement) =>   WeatherForeastMapper.forecastWeatherToEntity(toElement)).toList() 
            ;
          
      return weatherDays;
    
  }
}
