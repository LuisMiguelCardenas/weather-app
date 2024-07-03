import 'package:clima_exito/config/helpers/helpers.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/presentation/widgets/shared/icon_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class GeneralDescriptionWeather extends StatelessWidget {
  const GeneralDescriptionWeather({
    super.key,
    required this.weatherData,
    required this.ref,
  });

  final WeatherData weatherData;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);
    final imageCurrent =
        weatherData.iconWeather.isNotEmpty ? weatherData.iconWeather : '';

    return Container(
      child: weatherData.descriptionWeather.isEmpty
          ? const CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  weatherData.name.isNotEmpty ? weatherData.name : 'Unknown',
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.w400),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/wn/$imageCurrent@2x.png',
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        Text(
                          '${weatherData.temperature.round()}\u00B0',
                          style: const TextStyle(
                              fontSize: 60, fontWeight: FontWeight.w300),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -10),
                          child: Text(
                            capitalize(weatherData.descriptionWeather),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                IconsDescription(weatherData: weatherData)
              ],
            ),
    );
  }
}
