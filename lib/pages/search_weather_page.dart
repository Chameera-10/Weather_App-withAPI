import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/display_weatherdata.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherServices _weatherServices = WeatherServices(
    apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? "",
  );

  Weather? _weather;
  String? _error;

  final TextEditingController _controller = TextEditingController();

  void _searchWeather() async {
    final city = _controller.text.trim();

    if (city.isEmpty) {
      setState(() {
        _error = 'Please Enter a City Name';
      });
      return;
    }
    try {
      final weather = await _weatherServices.getWeather(city);
      setState(() {
        _weather = weather;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Could not find weather data for $city';
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Weather")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'City Name',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: _searchWeather,
                    icon: Icon(Icons.search),
                  ),
                ),
                onSubmitted: (value) => _searchWeather(),
              ),
              const SizedBox(height: 15),
              _error != null
                  ? Text(_error!, style: TextStyle(color: Colors.red))
                  : _weather != null
                  ? WeatherDisplay(weather: _weather!)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
