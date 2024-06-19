import 'package:clima_exito/config/constants/environment.dart';
import 'package:clima_exito/domain/datasources/weather_datasource.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/infraestructure/mappers/weather_mapper.dart';
import 'package:clima_exito/infraestructure/models/openweather/openweather_response.dart';
import 'package:dio/dio.dart';

// class OpenweatherDatasourceImpl extends WeatherDatasource {
//   final dio = Dio(BaseOptions(queryParameters: {
//     'appid': Environment.openWeatherKey,
//     'lat': '4.86',
//     'lon': '-74.053',
//     'units': 'metric'
//   }));

//   @override
//   Future<WeatherData> getCurrent() async {
//     final response =
//         await dio.get('https://api.openweathermap.org/data/2.5/weather');
// // response.data;

//     final openweatherResponse = OpenWeatherResponse.fromJson(response.data);
//     final WeatherData weather =
//         WeatherMapper.openWeatherToEntity(openweatherResponse);

//     return weather;
//   }
// }

class OpenweatherDatasourceImpl extends WeatherDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.openweathermap.org/data/2.5/',
  ));

  @override
  Future<WeatherData> getCurrent({String lat='0', String lon='0'}) async {
 
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
  Future<WeatherData> getByCity({String city = 'London'}) async {

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

    print('$response ######################################################');

    final openweatherResponse = OpenWeatherResponse.fromJson(response.data);
    final WeatherData weather =
        WeatherMapper.openWeatherToEntity(openweatherResponse);

    return weather;
      
    } catch (e) {

      print('$e=====================================');

       return {} as WeatherData ;
    }
  }
}
