import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/infraestructure/models/openweather/openweather_response.dart';

class WeatherMapper {

  static WeatherData openWeatherToEntity( OpenWeatherResponse openWeatherResponse ) => WeatherData(
    base: openWeatherResponse.base,
    clouds: openWeatherResponse.clouds.all, 
    cod: openWeatherResponse.cod,
    dt: openWeatherResponse.dt,
    id: openWeatherResponse.id,
    temperature: openWeatherResponse.main.temp,
    humidity: openWeatherResponse.main.humidity,
    name: openWeatherResponse.name,
    timezone: openWeatherResponse.timezone,
    visibility: openWeatherResponse.visibility,
    idWeather: openWeatherResponse.weather[0].id,
    mainWeather: openWeatherResponse.weather[0].main,
    descriptionWeather: openWeatherResponse.weather[0].description,
    iconWeather: openWeatherResponse.weather[0].icon,
    windDeg: openWeatherResponse.wind.deg,
    windGust: openWeatherResponse.wind.gust,
    windSpeed: openWeatherResponse.wind.speed
  );

}

