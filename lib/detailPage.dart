// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:weather/model/tomorrow_model.dart';
import 'package:http/http.dart' as http;

/// To display for upcoming days weather

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<List<Tomorrow>> getData() async {
    List<Tomorrow> list1;
    var endpoint = Uri.parse(
        "http://api.openweathermap.org/data/2.5/forecast?q=CHENNAI&appid=c5c630a04ee4f1aae71728d960e807c3&units=metric");

    var response = await http.get(endpoint);
    var data = json.decode(response.body);
    var rest = data["list"] as List;
    print(rest);
    list1 = rest.map<Tomorrow>((json) => Tomorrow.fromJson(json)).toList();

    print("List Size: ${list1.length}");
    return list1;
  }

  Widget listViewWidget(List<Tomorrow> tomorrow) {
    return GridView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(20.0),
      itemBuilder: (context, position) {
        return Card(
          color: Colors.lime,
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                '${tomorrow[position].date}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Image.network('https://openweathermap.org/img/w/04d.png',
                  height: 90, width: 90, fit: BoxFit.fill),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Text(
                "Temp: "
                '${tomorrow[position].main!.temp_max?.toStringAsFixed(1)}\u2103',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 20),
    );
  }

  /// Build method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Upcoming Hours"),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data as dynamic)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
