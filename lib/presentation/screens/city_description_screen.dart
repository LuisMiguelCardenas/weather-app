import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/presentation/providers/providers.dart';
import 'package:clima_exito/presentation/widgets/weather/next_days_weather.dart';
import 'package:clima_exito/presentation/widgets/weather/today_weather.dart';
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
    final colors = Theme.of(context).colorScheme;
    final WeatherData? city =
        ref.watch(weatherCityInfoProvider)[widget.cityName];

    if (city == null || city.descriptionWeather.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralDescriptionWeather(weatherData: city, ref: ref),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Later'),
              ),
              TodayWeather(lon: city.lon, lat: city.lat),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.primary,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text('Next Days'),
                  ),
                ),
              ),
              NextDaysWeather(lon: city.lon, lat: city.lat),
            ],
          )),
    );
  }
}
