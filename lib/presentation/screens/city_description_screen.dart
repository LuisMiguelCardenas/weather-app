import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/presentation/providers/providers.dart';
import 'package:clima_exito/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CityDescriptionScreen extends ConsumerStatefulWidget {
  static const name = 'city-description-screen';

  final String cityName;

  const CityDescriptionScreen({super.key, required this.cityName});

  @override
  CityDescriptionScreenState createState() => CityDescriptionScreenState();
}

class CityDescriptionScreenState extends ConsumerState<CityDescriptionScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(weatherCityInfoProvider.notifier).loadcity(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    final WeatherData? city =
        ref.watch(weatherCityInfoProvider)[widget.cityName];

    if (city == null || city.descriptionWeather.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      ));
    }

    return SafeArea(
        child: CityDescription(
      weather: city,
      ref: ref,
    ));
  }
}
