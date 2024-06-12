
import 'package:clima_exito/domain/entities/weather.dart';

abstract class WeatherDatasource {

  Future<WeatherData> getCurrent();
}