import 'package:animate_do/animate_do.dart';
import 'package:clima_exito/config/helpers/helpers.dart';
import 'package:clima_exito/domain/entities/weatherForecast.dart';
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
    final filterDayNotToday = filterForecastsByDate(weatherdays);
    final todayweather = weatherdays.length - filterDayNotToday.length;

    return Expanded(
        child: todayweather == 0
            ? const Center(child: Text('No data for today'))
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherdays.length - filterDayNotToday.length,
                itemBuilder: (context, index) {
                  //return Placeholder();
                  return FadeInRight(
                      child:
                          _Slide(weatherForecast: weatherdays, index: index));
                },
              ));
  }
}

class _Slide extends StatelessWidget {
  final List<WeatherForecast> weatherForecast;
  final int index;

  const _Slide({required this.weatherForecast, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                Text('${weatherForecast[0].temperature.round()}\u00B0'),
                Image.network(
                  'https://openweathermap.org/img/wn/${weatherForecast[index].icon}@2x.png',
                  // weatherForecast[0].icon,
                  fit: BoxFit.cover,
                  width: 50,
                ),
                Text(DateFormat('HH:mm')
                    .format(weatherForecast[index].datehour)
                    .toString())
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
