import 'package:clima_exito/domain/entities/weatherForecast.dart';
import 'package:clima_exito/infraestructure/models/forecast/weather_forecast_response.dart';

class WeatherForeastMapper {

  static WeatherForecast forecastWeatherToEntity( WeatherDayResponse  forecastWeatherResponse ) => WeatherForecast(
    datehour: forecastWeatherResponse.dtTxt ,
    icon: forecastWeatherResponse.weather.isNotEmpty ? forecastWeatherResponse.weather[0].icon:'',
    temMin: forecastWeatherResponse.main.tempMin,
    tempMax: forecastWeatherResponse.main.tempMax,
    temperature: forecastWeatherResponse.main.temp 
  );

}