import 'package:clima_exito/infraestructure/datasources/openweather_datasource_impl.dart';
import 'package:clima_exito/infraestructure/repositories/weather_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherRepositoryProvider = Provider((ref) {

  return WeatherRepositoryImpl(OpenweatherDatasourceImpl());
});