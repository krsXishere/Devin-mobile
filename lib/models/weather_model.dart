import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

String adress = '';

class WeatherModel {
  String statusWeather, weatherIcon;
  double tempC;

  WeatherModel({
    required this.statusWeather,
    required this.weatherIcon,
    required this.tempC,
  });

  factory WeatherModel.createWeather(Map<String, dynamic> object) {
    var currentObject = object['current'];
    var conditionObject = object['current']['condition'];

    return WeatherModel(
      statusWeather: conditionObject['text'],
      weatherIcon: conditionObject['icon'],
      tempC: currentObject['temp_c'],
    );
  }

  static Future<WeatherModel> sendRequest(String adress) async {
    String apiURL =
        "http://api.weatherapi.com/v1/current.json?key=16e64beba9ba4f2ab5d64054220902&q=$adress&aqi=no";
    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    var weatherData = (jsonObject as Map<String, dynamic>);

    return WeatherModel.createWeather(weatherData);
  }
}
