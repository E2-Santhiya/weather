// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/services/weather_api_client.dart';
import 'package:weather/views/additional_information.dart';
import 'package:weather/views/current_weather.dart';
import 'package:weather/detailPage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  Weather? data1;
  Weather? data2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // client.getCurrentWeather("Chennai");
  }

  Future<List<Weather>> getData1() async {
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

  Future<void> getData() async {
    data = await client.getCurrentWeather("Chennai");
  }

  /// Build method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFf9f9f9),
        appBar: AppBar(
            backgroundColor: const Color(0xFFf9f9f9),
            elevation: 0.0,
            title: const Text("Weather app",
                style: TextStyle(color: Colors.black)),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              color: Colors.black,
            )),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentWeather(
                      " https://openweathermap.org/img/w/04d.png,",
                      "${data?.temp?.toStringAsFixed(1)}\u00B0C",
                      "${data?.city}",
                      // (data!.city ?? " "),
                      Jiffy().yMMMd,
                      DateFormat.jm().format(DateTime.now()),
                      "${data?.description}",
                      // "${data?.lat}",
                      // "${data?.lon}",
                      "${data?.temp_min?.toStringAsFixed(1)}\u00B0C",
                      "${data?.temp_max?.toStringAsFixed(1)}\u00B0C"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10.0)),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24.0, color: Colors.blueAccent),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  additionalInformation("${data?.wind}", "${data?.humidity}",
                      "${data?.pressure}", "${data?.feels_like}"),
                  const Padding(padding: EdgeInsets.only(right: 60.0)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(right: 10.0)),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          const Text(
                            "More Days",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  getData1();

                                  return DetailPage();
                                }));
                              },
                              child: Row(
                                children: const [
                                  Padding(
                                      padding: EdgeInsets.only(left: 210.0)),
                                  Text(
                                    "Today",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.blue,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        for (var i = 0; i < 5; i++)
                          forecastElement(
                            i + 1,
                            data?.temp1,
                            data?.temp2,
                          ),
                      ],
                    ),
                  ),
                ],
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ));
  }
}

Widget forecastElement(
  daysFromNow,
  //dates,
  temperature,
  hours,
) {
  var now = DateTime.now();
  var oneDayFromNow = now.add(Duration(days: daysFromNow));
  return Padding(
    padding: const EdgeInsets.only(left: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(205, 212, 228, 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              DateFormat.MMMd().format(oneDayFromNow),
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Icon(
                Icons.wb_sunny_rounded,
                color: Colors.orange,
                size: 50.0,
              ),
            ),
            Text(
              'High:  ' + temperature.toStringAsFixed(1) + ' °C',
              style: TextStyle(color: Colors.black, fontSize: 12.0),
            ),
            Text(
              'Low:  ' + hours.toStringAsFixed(1) + ' °C',
              style: TextStyle(color: Colors.black, fontSize: 12.0),
            ),
          ],
        ),
      ),
    ),
  );
}
