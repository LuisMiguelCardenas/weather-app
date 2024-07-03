//import 'package:clima_exito/infraestructure/models/forecast/weather_forecast_response.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets.dart';

class CityDescription extends StatelessWidget {
  const CityDescription({
    super.key,
    required this.weather,
    required this.ref,
  });

  final WeatherData weather;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          GeneralDescriptionWeather(weatherData: weather, ref: ref),
          TodayWeather(
            lat: weather.lat,
            lon: weather.lon,
          ),
          NextDaysWeather(
            lat: weather.lat,
            lon: weather.lon,
          ),
        ]),
      ),
    );
  }
}