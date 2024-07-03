class WeatherForecastResponse {
    final String cod;
    final int message;
    final int cnt;
    final List<WeatherDayResponse> list;
    final City city;

    WeatherForecastResponse({
        required this.cod,
        required this.message,
        required this.cnt,
        required this.list,
        required this.city,
    });

    factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) => WeatherForecastResponse(
        cod: json["cod"] ?? "",
        message: json["message"] ?? 0,
        cnt: json["cnt"] ?? 0,
        list: json["list"] != null ? List<WeatherDayResponse>.from(json["list"].map((x) => WeatherDayResponse.fromJson(x))) : [],
        city: json["city"] != null ? City.fromJson(json["city"]) : City.defaultCity(),
    );

    Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "city": city.toJson(),
    };
}

class City {
    final int id;
    final String name;
    final Coord coord;
    final String country;
    final int population;
    final int timezone;
    final int sunrise;
    final int sunset;

    City({
        required this.id,
        required this.name,
        required this.coord,
        required this.country,
        required this.population,
        required this.timezone,
        required this.sunrise,
        required this.sunset,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        coord: json["coord"] != null ? Coord.fromJson(json["coord"]) : Coord.defaultCoord(),
        country: json["country"] ?? "",
        population: json["population"] ?? 0,
        timezone: json["timezone"] ?? 0,
        sunrise: json["sunrise"] ?? 0,
        sunset: json["sunset"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
    };

    static City defaultCity() => City(
        id: 0,
        name: "",
        coord: Coord.defaultCoord(),
        country: "",
        population: 0,
        timezone: 0,
        sunrise: 0,
        sunset: 0,
    );
}

class Coord {
    final double lat;
    final double lon;

    Coord({
        required this.lat,
        required this.lon,
    });

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble() ?? 0.0,
        lon: json["lon"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
    };

    static Coord defaultCoord() => Coord(
        lat: 0.0,
        lon: 0.0,
    );
}

class WeatherDayResponse {
    final int dt;
    final MainClass main;
    final List<Weather> weather;
    final Clouds clouds;
    final Wind wind;
    final int? visibility;
    final double pop;
    final Sys sys;
    final DateTime dtTxt;
    final Rain? rain;

    WeatherDayResponse({
        required this.dt,
        required this.main,
        required this.weather,
        required this.clouds,
        required this.wind,
        this.visibility,
        required this.pop,
        required this.sys,
        required this.dtTxt,
        this.rain,
    });

    factory WeatherDayResponse.fromJson(Map<String, dynamic> json) => WeatherDayResponse(
        dt: json["dt"] ?? 0,
        main: json["main"] != null ? MainClass.fromJson(json["main"]) : MainClass.defaultMain(),
        weather: json["weather"] != null ? List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))) : [],
        clouds: json["clouds"] != null ? Clouds.fromJson(json["clouds"]) : Clouds(all: 0),
        wind: json["wind"] != null ? Wind.fromJson(json["wind"]) : Wind.defaultWind(),
        visibility: json["visibility"],
        pop: json["pop"]?.toDouble() ?? 0.0,
        sys: json["sys"] != null ? Sys.fromJson(json["sys"]) : Sys.defaultSys(),
        dtTxt: DateTime.parse(json["dt_txt"] ?? '1970-01-01T00:00:00Z'),
        rain: json["rain"] != null ? Rain.fromJson(json["rain"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds.toJson(),
        "wind": wind.toJson(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys.toJson(),
        "dt_txt": dtTxt.toIso8601String(),
        "rain": rain?.toJson(),
    };
}

class Clouds {
    final int all;

    Clouds({
        required this.all,
    });

    factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "all": all,
    };
}

class MainClass {
    final double temp;
    final double feelsLike;
    final double tempMin;
    final double tempMax;
    final int pressure;
    final int seaLevel;
    final int grndLevel;
    final int humidity;
    final double tempKf;

    MainClass({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.seaLevel,
        required this.grndLevel,
        required this.humidity,
        required this.tempKf,
    });

    factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"]?.toDouble() ?? 0.0,
        feelsLike: json["feels_like"]?.toDouble() ?? 0.0,
        tempMin: json["temp_min"]?.toDouble() ?? 0.0,
        tempMax: json["temp_max"]?.toDouble() ?? 0.0,
        pressure: json["pressure"] ?? 0,
        seaLevel: json["sea_level"] ?? 0,
        grndLevel: json["grnd_level"] ?? 0,
        humidity: json["humidity"] ?? 0,
        tempKf: json["temp_kf"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
    };

    static MainClass defaultMain() => MainClass(
        temp: 0.0,
        feelsLike: 0.0,
        tempMin: 0.0,
        tempMax: 0.0,
        pressure: 0,
        seaLevel: 0,
        grndLevel: 0,
        humidity: 0,
        tempKf: 0.0,
    );
}

class Rain {
    final double the3H;

    Rain({
        required this.the3H,
    });

    factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "3h": the3H,
    };
}

class Sys {
    final Pod pod;

    Sys({
        required this.pod,
    });

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: podValues.map[json["pod"]] ?? Pod.D,
    );

    Map<String, dynamic> toJson() => {
        "pod": podValues.reverse[pod],
    };

    static Sys defaultSys() => Sys(
        pod: Pod.D,
    );
}

enum Pod {
    D,
    N
}

final podValues = EnumValues({
    "d": Pod.D,
    "n": Pod.N
});

class Weather {
    final int id;
    final MainEnum main;
    final String description;
    final String icon;

    Weather({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] ?? 0,
        main: mainEnumValues.map[json["main"]] ?? MainEnum.CLEAR,
        description: json["description"] ?? "",
        icon: json["icon"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainEnumValues.reverse[main],
        "description": description,
        "icon": icon,
    };
}

enum MainEnum {
    CLEAR,
    CLOUDS,
    RAIN
}

final mainEnumValues = EnumValues({
    "Clear": MainEnum.CLEAR,
    "Clouds": MainEnum.CLOUDS,
    "Rain": MainEnum.RAIN
});

class Wind {
    final double speed;
    final int deg;
    final double gust;

    Wind({
        required this.speed,
        required this.deg,
        required this.gust,
    });

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble() ?? 0.0,
        deg: json["deg"] ?? 0,
        gust: json["gust"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };

    static Wind defaultWind() => Wind(
        speed: 0.0,
        deg: 0,
        gust: 0.0,
    );
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
