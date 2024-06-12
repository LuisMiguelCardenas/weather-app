
import 'package:clima_exito/domain/entities/weather.dart';

abstract class WeatherRepository {

  Future<WeatherData> getCurrent();
}