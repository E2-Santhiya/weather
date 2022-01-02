import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:weather/model/today_model.dart';
import 'package:http/http.dart' as http;

/// To display today weather

class TodayWeather extends StatefulWidget {
  const TodayWeather({Key? key}) : super(key: key);

  @override
  _TodayWeatherState createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  Future<List<Today>> getData1() async {
    List<Today> list1;
    var endpoint = Uri.parse(
        "http://api.openweathermap.org/data/2.5/forecast?q=CHENNAI&appid=c5c630a04ee4f1aae71728d960e807c3&units=metric");

    var response = await http.get(endpoint);
    var data2 = json.decode(response.body);
    var rest = data2["list"] as List;
    print(rest);
    list1 = rest.map<Today>((json) => Today.fromJson(json)).toList();
    print("List Size: ${list1.length}");
    return list1;
  }

  Widget listViewWidget(List<Today> today) {
    return Container(
        child: ListView.builder(
      itemCount: 4,
      padding: const EdgeInsets.all(40.0),
      itemBuilder: (context, position) {
        return Card(
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(20.0),
            title: Text(
              "Temp "
              '${today[position].main!.temp_max}\u00B0C',
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Text(
                  "Humdity: "
                  '${today[position].main!.humidity}',
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
                height: 100.0,
                width: 100.0,
              ),
            ),
          ),
        );
      },
    ));
  }

  /// Build method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Upcoming hours weather"),
      ),
      body: FutureBuilder(
          future: getData1(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data as dynamic)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
