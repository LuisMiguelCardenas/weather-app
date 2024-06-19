import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitiesView extends ConsumerStatefulWidget {
  const CitiesView({super.key});

  @override
  CitiesViewState createState() => CitiesViewState();
}

class CitiesViewState extends ConsumerState<CitiesView> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  String _displayCityText = '';

  @override
  Widget build(BuildContext context) {
    final citiesWeather = ref.watch(cityWeatherProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (citiesWeather.isNotEmpty && _displayCityText.isEmpty) {
        setState(() {
          _displayCityText =
              citiesWeather.map((weather) => weather.name).join(', ');
        });
      }
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_displayCityText),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
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
                    // controller: scrollController,
                    itemCount: citiesWeather.length,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _CardWeather(cityWeather: citiesWeather[index]);
                    }))
        ],
      ),
    );
  }
}

class _CardWeather extends StatelessWidget {
  final WeatherData cityWeather;

  const _CardWeather({required this.cityWeather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${cityWeather.temperature.round()}\u00B0',
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      cityWeather.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${cityWeather.iconWeather}@2x.png',
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )),
    );
  }
}
