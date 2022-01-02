import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/model/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "http://api.openweathermap.org/data/2.5/forecast?q=CHENNAI&appid=c5c630a04ee4f1aae71728d960e807c3&units=metric");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body));
    return Weather.fromJson(body);
  }

  Future<List<Weather>>? getData(String s) async {
    List<Weather> list1;
    var endpoint = Uri.parse(
        "http://api.openweathermap.org/data/2.5/forecast?q=CHENNAI&appid=c5c630a04ee4f1aae71728d960e807c3&units=metric");

    var response = await http.get(endpoint);
    var data = json.decode(response.body);
    var rest = data["list"] as List;
    print(rest);
    list1 = rest.map<Weather>((json) => Weather.fromjson(json)).toList();

    print("List Size: ${list1.length}");
    return list1;
  }
}
