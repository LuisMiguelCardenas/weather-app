import 'package:clima_exito/domain/datasources/weather_datasource.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {


final WeatherDatasource datasource;

  WeatherRepositoryImpl(this.datasource);

  @override
  Future<WeatherData> getCurrent({String lat='0', String lon='0'}) {
    return datasource.getCurrent(lat: lat, lon: lon);
  }
  
  @override
  Future<WeatherData> getByCity({String city = 'London'}) {
    return datasource.getByCity(city: city);
  }

}