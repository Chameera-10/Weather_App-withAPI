import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/util_functions.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                UtilFunctions().getWeatherAnimation(
                  condition: weather.condition,
                ),
                width: 400,
                height: 400,
              ),
            ),
            Text(
              weather.cityName,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "${weather.temperature.toStringAsFixed(1)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                ),
                Text(
                  "°C",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  weather.condition,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Text(
                  '-${weather.description}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetails("Pressure", "${weather.pressure} hPa"),
                _buildWeatherDetails("Humidity", "${weather.humidity} %"),
                _buildWeatherDetails("Wind Speed", "${weather.windSpeed} m/s"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails(String lable, String value) {
    return Column(
      children: [
        Text(lable, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
        ),
      ],
    );
  }
}
