import 'dart:convert';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

class Weather {
  Weather({
    this.condition,
    this.formattedCondition,
    this.time,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.location,
    this.woeid,
    this.timezone,
    this.predictability,
    this.speed,
  });

  WeatherCondition condition;
  String formattedCondition;
  DateTime time;
  double minTemp;
  double temp;
  double maxTemp;
  String location;
  int woeid;
  String timezone;
  String predictability;
  double speed;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
        condition: _mapStringToWeatherCondition(
            consolidatedWeather['weather_state_abbr']),
        formattedCondition: consolidatedWeather['weather_state_name'],
        time: DateTime.parse(json["time"]),
        minTemp: consolidatedWeather['minTemp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        location: json["title"],
        woeid: json["woeid"],
        timezone: json["timezone"],
        predictability: consolidatedWeather['predictability'], 
        speed: consolidatedWeather['wind_speed'] as double,
      );
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}
