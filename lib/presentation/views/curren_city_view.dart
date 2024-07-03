import 'package:clima_exito/presentation/providers/weathers/weathers_providers.dart';
import 'package:clima_exito/presentation/widgets/weather/next_days_weather.dart';
import 'package:clima_exito/presentation/widgets/weather/today_weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';


import '../widgets/weather/general_description_weather.dart';

final positionProvider =
    StateNotifierProvider<PositionNotifier, Position?>((ref) {
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
    _initialize();
  }

  Future<void> _initialize() async {
    if (!mounted) return;
    await ref.read(positionProvider.notifier).updatePosition();
    if (!mounted) return;
    final position = ref.read(positionProvider);
    if (position != null) {
      ref.read(currentWeatherProvider.notifier).loadNextWeather(
            position.latitude.toString(),
            position.longitude.toString(),
          );




    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = ref.watch(currentWeatherProvider);



    if (currentWeather.iconWeather == '' || currentWeather.descriptionWeather.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      ));
    }

    return Column(children: [
      GeneralDescriptionWeather(weatherData: currentWeather, ref: ref),
       TodayWeather(lat: currentWeather.lat, lon: currentWeather.lon,),
       NextDaysWeather (lat: currentWeather.lat, lon: currentWeather.lon,),
      ]);
  }
}


