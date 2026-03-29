import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/display_weatherdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherServices _weatherServices = WeatherServices(
    apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "",
  );

  Weather? _weather;

  void fetchWeather() async {
    try {
      final weather = await _weatherServices.getWeatherFromLocation();

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error from weather data:$e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.light_mode_rounded)),
        ],
      ),
      body: _weather != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [WeatherDisplay(weather: _weather!)],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
