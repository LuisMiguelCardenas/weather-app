class WeatherForecast {
  final DateTime datehour;
  final String icon;
  final double temperature;
  final double temMin;
  final double tempMax;

  WeatherForecast({
    required this.datehour,
    required this.icon,
    required this.temperature,
    required this.temMin,
    required this.tempMax,
  });
}
