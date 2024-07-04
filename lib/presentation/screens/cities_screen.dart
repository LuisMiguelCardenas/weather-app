import '../providers/providers.dart';
import 'package:clima_exito/domain/entities/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CitiesScreen extends ConsumerStatefulWidget {
  static const name = 'cities-screen';
  const CitiesScreen({super.key});

  @override
  CitiesViewState createState() => CitiesViewState();
}

class CitiesViewState extends ConsumerState<CitiesScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  String _displayCityText = '';

  @override
  Widget build(BuildContext context) {
    final citiesWeather = ref.watch(cityWeatherProvider);
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (citiesWeather.isNotEmpty && _displayCityText.isEmpty) {
        setState(() {
          _displayCityText =
              citiesWeather.map((weather) => weather.name).join(', ');
        });
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cities'),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(themeNotifierProvider.notifier).toggleDarkMode();
                },
                icon: Icon(isDarkmode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_displayCityText),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  autofocus: false,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter city',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    ref
                        .read(cityWeatherProvider.notifier)
                        .loadCityWeather(_controller.text);
                    setState(() {
                      _displayCityText = _controller.text;
                      _controller.clear();
                    });
                  }
                },
                child: const Text('Add city'),
              ),
              if (_displayCityText.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                        itemCount: citiesWeather.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _CardWeather(
                              cityWeather: citiesWeather[index]);
                        }))
            ],
          ),
        ));
  }
}

class _CardWeather extends StatelessWidget {
  final WeatherData cityWeather;

  const _CardWeather({required this.cityWeather});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 6,
              backgroundColor: colors.primaryContainer),
          onPressed: () => context.push('/cities/city/${cityWeather.name}'),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cityWeather.temperature.round()}\u00B0',
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        cityWeather.name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre el texto y la imagen
                Image.network(
                  'https://openweathermap.org/img/wn/${cityWeather.iconWeather}@2x.png',
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
