import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/get_location_service.dart';

class WeatherServices {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    try {
      final url = '$BASE_URL?q=$cityName&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Faild to load the weather data');
      }
    } catch (error) {
      throw Exception('Faild to load the weather data');
    }
  }

  Future<Weather> getWeatherFromLocation() async {
    try {
      final location = GetLocationService();
      final cityName = await location.getCityNameFromCurrentLocation();

      final url = '$BASE_URL?q=$cityName&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Fail to Load Weather Data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Fail to Load Weather Data');
    }
  }
}
