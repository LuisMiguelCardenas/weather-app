import 'package:animate_do/animate_do.dart';
import 'package:clima_exito/config/helpers/helpers.dart';
import 'package:clima_exito/domain/entities/weather_forecast.dart';
import 'package:clima_exito/presentation/providers/weathers/weathers_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TodayWeather extends ConsumerStatefulWidget {
  final double lon;
  final double lat;

  const TodayWeather({super.key, required this.lon, required this.lat});

  @override
  TodayWeatherState createState() => TodayWeatherState();
}

class TodayWeatherState extends ConsumerState<TodayWeather> {
  @override
  void initState() {
    super.initState();

    ref
        .read(cityForecastProvider.notifier)
        .loadForecastWeather(widget.lat.toString(), widget.lon.toString());
  }

  @override
  Widget build(BuildContext context) {
    final weatherdays = ref.watch(cityForecastProvider);
    final filterDayNotToday = filterForecastsByNotToday(weatherdays);
    final todayweather = weatherdays.length - filterDayNotToday.length;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return todayweather == 0
        ? const Center(child: Text('No data for today'))
        : Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Today',
                  style: titleStyle,
                ),
              ),
            ),
            SizedBox(
              height: 150, // Ajusta esta altura según sea necesario
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherdays.length - filterDayNotToday.length,
                itemBuilder: (context, index) {
                  return FadeInRight(
                      child:
                          _Slide(weatherForecast: weatherdays, index: index));
                },
              ),
            )
          ]);
  }
}

class _Slide extends StatelessWidget {
  final List<WeatherForecast> weatherForecast;
  final int index;

  const _Slide({required this.weatherForecast, required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 90,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            decoration: BoxDecoration(
              color: index == 0 ? colors.primaryContainer : colors.onPrimary,
              border: Border.all(
                color: colors.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  Text(DateFormat('h:mm a')
                      .format(weatherForecast[index].datehour)
                      .toString()),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weatherForecast[index].icon}@2x.png',
                    // weatherForecast[0].icon,
                    fit: BoxFit.cover,
                    width: 50,
                  ),
                  Text('${weatherForecast[index].temperature.round()}\u00B0'),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
