import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/models.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl = "$baseUrl/api/location/search/?query=$city";
    final locationResponse = await httpClient.get(locationUrl);
    if (locationResponse.statusCode == 200) {
      final locationJson = jsonDecode(locationResponse.body) as List;
      return (locationJson.first)['woeid'];
    } else {
      throw Exception('Error getting locationid for city');
    }
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await httpClient.get(weatherUrl);
    if (weatherResponse.statusCode == 200) {
      final weatherjson = jsonDecode(weatherResponse.body);
      return Weather.fromJson(weatherjson);
    } else {
      throw Exception('error getting weather for location');
    }
  }
}






















// abstract class WeatherClient {
//   Future<Weather> fetchWeather(String city);

//   Future<int> getLocationId(int locationId);
// }

// class WeatherApiClient implements WeatherClient {
//   static const baseUrl = 'https://www.metaweather.com';
//   @override
//   Future<Weather> fetchWeather(String city) async {
//     final weatherUrl = '$baseUrl/api/location/search/?query=$city';
//     final weatherResponse = await http.get(weatherUrl);
//     if (weatherResponse.statusCode != 200) {
//       throw Exception('error getting weather for location');
//     }
//     final weatherJson = jsonDecode(weatherResponse.body);
//     return Weather.fromJson(weatherJson);
//   }

//   @override
//   Future<int> getLocationId(int locationId) async {
//     final locationUrl = '$baseUrl/api/location/$locationId';
//     final locationResponse = await http.get(locationUrl);
//     if (locationResponse.statusCode == 200) {
//       final locationJson = jsonDecode(locationResponse.body) as List;
//       return (locationJson.first)['woeid'];
//     } else {
//       throw Exception('error getting locationId for city');
//     }
//   }
// }
