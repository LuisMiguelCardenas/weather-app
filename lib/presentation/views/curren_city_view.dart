import 'package:clima_exito/config/helpers/helpers.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/presentation/providers/weathers/weathers_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

final positionProvider = StateNotifierProvider<PositionNotifier, Position?>((ref) {
  return PositionNotifier();
});

class PositionNotifier extends StateNotifier<Position?> {
  PositionNotifier() : super(null);

  Future<void> updatePosition() async {
    Position position = await _determinePosition();
    state = position;
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

class CurrentCityView extends ConsumerStatefulWidget {
  const CurrentCityView({super.key});

  @override
  CurrentCityViewState createState() => CurrentCityViewState();
}

class CurrentCityViewState extends ConsumerState<CurrentCityView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(positionProvider.notifier).updatePosition();
      final position = ref.read(positionProvider);
      if (position != null) {
        ref.read(currentWeatherProvider.notifier).loadNextWeather(position.latitude.toString(), position.longitude.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = ref.watch(currentWeatherProvider);
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);
    final imageCurrent = currentWeather.iconWeather.isNotEmpty ? currentWeather.iconWeather : '';

    return Scaffold(
      body: Center(
        child: currentWeather.descriptionWeather.isEmpty
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
                    currentWeather.name != '' ? currentWeather.name : 'Unknown',
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
                            '${currentWeather.temperature.round().toString()}\u00B0',
                            style: const TextStyle(
                                fontSize: 60, fontWeight: FontWeight.w300),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -10),
                            child: Text(
                              capitalize(currentWeather.descriptionWeather),
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
                  _IconsDescription(currentWeather: currentWeather),
                ],
              ),
      ),
    );
  }
}

class _IconsDescription extends StatelessWidget {
  const _IconsDescription({
    required this.currentWeather,
  });

  final WeatherData currentWeather;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> weatherDetails = [
      {'icon': Icons.air, 'value': '${currentWeather.windSpeed} m/s'},
      {'icon': Icons.cloud, 'value': '${currentWeather.clouds} %'},
      {
        'icon': Icons.water_drop_outlined,
        'value': '${currentWeather.humidity} %'
      }
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: weatherDetails.map((detail) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Icon(
                detail['icon'],
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              detail['value'],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        );
      }).toList(),
    );
  }
}
