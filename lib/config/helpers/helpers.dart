import 'package:clima_exito/domain/entities/weatherForecast.dart';

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
}


List<WeatherForecast> filterForecastsByDate(List<WeatherForecast> weatherDays) {
  DateTime todayWithoutTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<WeatherForecast> filteredList = weatherDays.where((forecast) {
    DateTime forecastDate = DateTime(forecast.datehour.year, forecast.datehour.month, forecast.datehour.day);
    return forecastDate != todayWithoutTime;
  }).toList();

  return filteredList;
}