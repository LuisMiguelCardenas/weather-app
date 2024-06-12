import 'package:clima_exito/domain/datasources/weather_datasource.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {


final WeatherDatasource datasource;

  WeatherRepositoryImpl(this.datasource);

  @override
  Future<WeatherData> getCurrent() {
    return datasource.getCurrent();
  }

}