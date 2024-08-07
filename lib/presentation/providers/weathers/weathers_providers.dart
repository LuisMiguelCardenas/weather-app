import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/domain/entities/weather_forecast.dart';
import 'package:clima_exito/presentation/providers/weathers/weathers_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diacritic/diacritic.dart';

final currentWeatherProvider =
    StateNotifierProvider<WeathersNotifier, WeatherData>((ref) {
  final fetchMoreWeather = ref.watch(weatherRepositoryProvider).getCurrent;
  return WeathersNotifier(fetchMoreWeather: fetchMoreWeather);
});

final cityWeatherProvider =
    StateNotifierProvider<WeathersCityNotifier, List<WeatherData>>((ref) {
  final fetchCityWeather = ref.watch(weatherRepositoryProvider).getByCity;
  return WeathersCityNotifier(fetchCityWeather: fetchCityWeather);
});

final cityForecastProvider =
    StateNotifierProvider<ForecastCityNotifier, List<WeatherForecast>>((ref) {
  final fetchForecastWeather =
      ref.watch(weatherRepositoryProvider).getTimeAndNextDays;
  return ForecastCityNotifier(fetchForecastWeather: fetchForecastWeather);
});

typedef WeatherCallBack = Future<WeatherData> Function(
    {String lat, String lon});

typedef WeatherCityCallBack = Future<WeatherData> Function(String city);

typedef ForecastCallBack = Future<List<WeatherForecast>> Function(
    {String lat, String lon});

class WeathersNotifier extends StateNotifier<WeatherData> {
  String currentLon = '-74.0817';
  String currentLat = '4.6097';
  WeatherCallBack fetchMoreWeather;

  WeathersNotifier({required this.fetchMoreWeather})
      : super(WeatherData(
          lat: 0,
          lon: 0,
          windDeg: 0,
          windGust: 0,
          windSpeed: 0,
          descriptionWeather: '',
          iconWeather: '',
          idWeather: 0,
          mainWeather: '',
          base: '',
          temperature: 0.0,
          humidity: 0,
          visibility: 0,
          clouds: 0,
          dt: 0,
          timezone: 0,
          id: 0,
          name: '',
          cod: 0,
        ));

  Future<void> loadNextWeather(String currentLat, String currentLon) async {
    final WeatherData weathers =
        await fetchMoreWeather(lat: currentLat, lon: currentLon);

    state = weathers;
  }
}

class WeathersCityNotifier extends StateNotifier<List<WeatherData>> {
  String city = 'Cajica';
  WeatherCityCallBack fetchCityWeather;

  WeathersCityNotifier({required this.fetchCityWeather}) : super([]);

  Future<void> loadCityWeather(String city) async {

    if (state.any((e) =>
        removeDiacritics(e.name.toUpperCase()) ==
        removeDiacritics(city.toUpperCase()))) {
      return;
    }

    final WeatherData weather = await fetchCityWeather(city);
  
    if(weather.name =='no_name') return;
    state = [weather, ...state];
  }
}

class ForecastCityNotifier extends StateNotifier<List<WeatherForecast>> {
  String currentLon = '-74.0817';
  String currentLat = '4.6097';
  ForecastCallBack fetchForecastWeather;

  ForecastCityNotifier({required this.fetchForecastWeather}) : super([]);

  Future<void> loadForecastWeather(String currentLat, String currentLon) async {
    final List<WeatherForecast> weathers =
        await fetchForecastWeather(lat: currentLat, lon: currentLon);

    state = [...weathers];
  }
}
