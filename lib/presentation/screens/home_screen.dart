import 'package:clima_exito/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(currentWeatherProvider.notifier).loadNextWeather();
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = ref.watch(currentWeatherProvider);

    return ListView.builder(
        itemCount: currentWeather.weather.length,
        itemBuilder: (context, index) {
          final weather = currentWeather.weather[index];
          return (ListTile(
            title: Text(weather.main),
          ));
        });
  }
}
