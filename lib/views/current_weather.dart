import 'package:flutter/material.dart';

Widget currentWeather(
    String icon,
    String temp,
    String location,
    String date,
    String time,
    String description,
    //String lat,
    //String lon,
    String temp_min,
    String temp_max) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 80.0, left: 20.0)),
          Text(date,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
          const SizedBox(height: 18.0),
        ]),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(left: 20.0, top: 20.0)),
            Text(time,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
          ],
        ),
        Card(
          color: Colors.lightBlue[100],
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12.0),
                      const Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 20.0)),
                      Text(temp,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.normal,
                              color: Colors.red)),
                      const SizedBox(height: 10.0),
                      const Padding(
                          padding: EdgeInsets.only(
                        left: 130.0,
                      )),
                      Image.network('https://openweathermap.org/img/w/04d.png',
                          height: 120, width: 120, fit: BoxFit.fill),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 20.0)),
                  Text(location,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.normal,
                          color: Colors.deepPurple)),
                  const Padding(padding: EdgeInsets.only(left: 120.0)),
                  Text(
                    temp_min,
                    style: const TextStyle(fontSize: 19.0, color: Colors.black),
                  ),
                  const Text("/",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black)),
                  Text(
                    temp_max,
                    style: const TextStyle(fontSize: 19.0, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                /*  children: [
                  const Padding(padding: EdgeInsets.only(left: 20.0)),
                  Text(lat,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black38)),
                  const SizedBox(height: 10.0),
                  const Text("/",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black38)),
                  Text(lon,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black38)),
                ],*/
              ),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 20.0)),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 19.0, color: Colors.orangeAccent),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        )
      ],
    ),
  );
}
