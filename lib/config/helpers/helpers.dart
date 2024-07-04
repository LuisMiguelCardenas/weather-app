import 'package:clima_exito/config/constants/colors_contants.dart';
import 'package:clima_exito/domain/entities/weather_forecast.dart';

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
}


List<WeatherForecast> filterForecastsByNotToday(List<WeatherForecast> weatherDays) {
  DateTime todayWithoutTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List<WeatherForecast> filteredList = weatherDays.where((forecast) {
    DateTime forecastDate = DateTime(forecast.datehour.year, forecast.datehour.month, forecast.datehour.day);
    return forecastDate != todayWithoutTime;
  }).toList();

  return filteredList;
}

List<WeatherForecast> filterForecastsByDate(List<WeatherForecast> weatherDays) {
  DateTime todayWithoutTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Set<DateTime> addedDates = <DateTime>{};

  List<WeatherForecast> filteredList = weatherDays.where((forecast) {
    DateTime forecastDate = DateTime(forecast.datehour.year, forecast.datehour.month, forecast.datehour.day);
    if (forecastDate != todayWithoutTime && !addedDates.contains(forecastDate)) {
      addedDates.add(forecastDate);
      return true;
    }
    return false;
  }).toList();

  return filteredList;
}


String getColorName(int colorValue) {
  return colorNames[colorValue] ?? 'Unknown color';
}