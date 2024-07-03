
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/domain/entities/weatherForecast.dart';

abstract class WeatherRepository {

  Future<WeatherData> getCurrent({String lat='0', String lon='0'});

  Future<WeatherData> getByCity(String city);

  Future<List<WeatherForecast>> getTimeAndNextDays({String lat='', String lon=''});
}