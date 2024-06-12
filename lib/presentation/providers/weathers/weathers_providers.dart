import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/presentation/providers/weathers/weathers_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clima_exito/infraestructure/models/openweather/openweather_response.dart';


final currentWeatherProvider = StateNotifierProvider<WeathersNotifier, WeatherData>((ref) {
  
  final fetchMoreWeather = ref.watch(weatherRepositoryProvider).getCurrent;
  
  return WeathersNotifier(
    fetchMoreWeather:fetchMoreWeather
  );
});


typedef WeatherCallBack = Future<WeatherData> Function();

class WeathersNotifier extends StateNotifier<WeatherData> {
  
  WeatherCallBack fetchMoreWeather;

  WeathersNotifier({
    required this.fetchMoreWeather
  }): super(

    WeatherData(
    coord: Coord(lon: 0.0, lat: 0.0), // Valores predeterminados o datos ficticios
    weather: [], // Lista vacía u otros valores predeterminados
    base: '',
    main: Main(
      temp: 0.0,
      feelsLike: 0.0,
      tempMin: 0.0,
      tempMax: 0.0,
      pressure: 0,
      humidity: 0,
      seaLevel: 0,
      grndLevel: 0,
    ),
    visibility: 0,
    wind: Wind(speed: 0.0, deg: 0, gust: 0.0),
    clouds: Clouds(all: 0),
    dt: 0,
    sys: Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0),
    timezone: 0,
    id: 0,
    name: '',
    cod: 0,
  )
  );


  Future<void> loadNextWeather() async {

  final WeatherData weathers = await fetchMoreWeather();
  
  state = weathers;
  }

}