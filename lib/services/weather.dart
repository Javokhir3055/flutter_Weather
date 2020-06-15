class WeatherData {
  final String main;
  final int id;
  final String description;
  final String icon;

  WeatherData({this.id, this.description, this.icon, this.main});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        main: json['main'],
        id: json['id'],
        description: json['description'],
        icon: json['icon']);
  }
}

class Weather {
  final double longitude;
  final double latitude;
  final List<WeatherData> weatherData;
  final base;
  final double temp;
  final pressure;
  final humidity;
  final double tempMin;
  final double tempMax;
  final double feelsLike;
  final double windSpeed;
  final deg;
  final clouds;
  final seaLevel;
  final grndLevel;
  final rain;
  final int date;
  final int sunriseTime;
  final int sunsetTime;
  final id;

  final int timezone;
  final String city;

  Weather(
      {this.feelsLike,
      this.windSpeed,
      this.deg,
      this.seaLevel,
      this.grndLevel,
      this.rain,
      this.id,
      this.base,
      this.longitude,
      this.latitude,
      this.weatherData,
      this.temp,
      this.pressure,
      this.humidity,
      this.tempMin,
      this.tempMax,
      this.clouds,
      this.date,
      this.sunriseTime,
      this.sunsetTime,
      this.timezone,
      this.city});

  factory Weather.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    List<WeatherData> weatherList =
        list.map((value) => WeatherData.fromJson(value)).toList();
    return Weather(
      windSpeed: json['wind']['speed'].toDouble(),
      deg: json['wind']['deg'],
      seaLevel: json['main']['sea_level'],
      feelsLike: json['main']['feels_like'].toDouble(),
      grndLevel: json['main']["grnd_level"],
      rain: json['3h'],
      id: json['id'],
      base: json['base'],
      longitude: json['coord']['lon'],
      latitude: json['coord']['lat'],
      weatherData: weatherList,
      temp: json['main']["temp"].toDouble(),
      pressure: json['main']["pressure"],
      humidity: json['main']["humidity"],
      tempMin: json['main']["temp_min"].toDouble(),
      tempMax: json['main']["temp_max"].toDouble(),
      clouds: json['clouds']['all'],
      date: json['dt'],
      sunriseTime: json['sys']['sunrise'],
      sunsetTime: json['sys']['sunset'],
      timezone: json['timezone'],
      city: json["name"],
    );
  }
}
