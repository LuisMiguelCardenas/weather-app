class WeatherData {
  final double lon;
  final double lat;
  final int idWeather;
  final String mainWeather;
  final String descriptionWeather;
  final String iconWeather;
  final String base;
  final double temperature;
  final int humidity;
  final int visibility;
  final int clouds;
  final int dt;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  final double windSpeed;
  final int windDeg;
  final double windGust;

  WeatherData({
    required this.lon,
    required this.lat,
    required this.idWeather,
    required this.mainWeather,
    required this.descriptionWeather,
    required this.iconWeather,
    required this.windDeg,
    required this.windSpeed,
    required this.windGust,
    required this.base,
    required this.temperature,
    required this.humidity,
    required this.visibility,
    required this.clouds,
    required this.dt,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherData.defaultInstance() {
    return WeatherData(
      lon: 0.0,
      lat: 0.0,
      idWeather: 0,
      mainWeather: '',
      descriptionWeather: '',
      iconWeather: '',
      windDeg: 0,
      windSpeed: 0.0,
      windGust: 0.0,
      base: '',
      temperature: 0.0,
      humidity: 0,
      visibility: 0,
      clouds: 0,
      dt: 0,
      timezone: 0,
      id: 0,
      name: 'no_name',
      cod: 0,
    );
  }
}
