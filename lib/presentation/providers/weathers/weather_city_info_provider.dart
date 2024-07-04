import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/presentation/providers/weathers/weathers_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherCityInfoProvider =
    StateNotifierProvider<CityMapNotifier, Map<String, WeatherData>>((ref) {
  final getCityDescription = ref.watch(weatherRepositoryProvider).getByCity;
  return CityMapNotifier(getCityDescription: getCityDescription);
});

typedef GetCityDescriptionCallback = Future<WeatherData> Function(
    String cityName);

class CityMapNotifier extends StateNotifier<Map<String, WeatherData>> {
  final GetCityDescriptionCallback getCityDescription;

  CityMapNotifier({required this.getCityDescription}) : super({});

  Future<void> loadcity(String cityName) async {
    if (state[cityName] != null) return;
    final city = await getCityDescription(cityName);

    state = {...state, cityName: city};
  }
}
