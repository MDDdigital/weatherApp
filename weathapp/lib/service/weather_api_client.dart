//to start call some http request in flutter we will need the flutter http package

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weathapp/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location,&APPID=7f3d8e4c91e25e414b6c71c5a872f5c4&units=metric");

    var resposne = await http.get(endpoint);
    var body = jsonDecode(resposne.body);
    print(Weather.fromJson(body).cityname);
    //or we can just do this
    return Weather.fromJson(body);
  }
}
