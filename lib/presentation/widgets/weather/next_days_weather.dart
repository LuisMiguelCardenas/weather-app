import 'package:animate_do/animate_do.dart';
import 'package:clima_exito/config/helpers/helpers.dart';
import 'package:clima_exito/presentation/providers/weathers/weathers_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class NextDaysWeather extends ConsumerStatefulWidget {
  final double lon;
  final double lat;

  const NextDaysWeather({
    super.key,
    required this.lon,
    required this.lat,
  });

  @override
  NextDaysWeatherState createState() => NextDaysWeatherState();
}

class NextDaysWeatherState extends ConsumerState<NextDaysWeather> {
  @override
  void initState() {
    super.initState();
    ref
        .read(cityForecastProvider.notifier)
        .loadForecastWeather(widget.lat.toString(), widget.lon.toString());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final weatherdays = ref.watch(cityForecastProvider);
    final filterDayNotToday = filterForecastsByDate(weatherdays);

    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Next Days',
              style: titleStyle,
            ),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: filterDayNotToday.length,
            itemBuilder: (context, index) {
              return FadeIn(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.circular(10),
                    border: Border(
                        top: BorderSide(
                            color: colors.onPrimaryFixed, width: 1.0)),
                    color: colors.surfaceContainerHigh,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('EEEE dd MMMM')
                            .format(filterDayNotToday[index].datehour)
                            .toString()),
                        Image.network(
                          'https://openweathermap.org/img/wn/${weatherdays[index].icon}@2x.png',
                          // weatherForecast[0].icon,
                          fit: BoxFit.cover,
                          width: 50,
                        ),
                        Text(
                            '${weatherdays[index].temMin.round()}\u00B0 / ${weatherdays[index].tempMax.round()}\u00B0')
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
