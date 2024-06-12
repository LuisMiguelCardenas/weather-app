import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String openWeatherKey =dotenv.env['OPEN_WEATHER_KEY'] ?? 'No hay api key';
}