import 'package:clima_exito/domain/entities/weather.dart';
import 'package:clima_exito/infraestructure/models/openweather/openweather_response.dart';

class WeatherMapper {

  static WeatherData openWeatherToEntity( OpenWeatherResponse openWeatherResponse ) => WeatherData(
    coord: openWeatherResponse.coord,
    base: openWeatherResponse.base,
    clouds: openWeatherResponse.clouds as dynamic,
    cod: openWeatherResponse.cod,
    dt: openWeatherResponse.dt,
    id: openWeatherResponse.id,
    main: openWeatherResponse.main as dynamic,
    name: openWeatherResponse.name,
    sys: openWeatherResponse.sys as dynamic,
    timezone: openWeatherResponse.timezone,
    visibility: openWeatherResponse.visibility,
    weather: openWeatherResponse.weather as dynamic,
    wind: openWeatherResponse.wind as dynamic
  );

}

