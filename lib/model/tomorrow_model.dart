//import 'package:weather/model/weather_model.dart';

/// Model for tomorrow weather

class Tomorrow {
  Source? main;
  String? date;

  Tomorrow({
    this.main,
    this.date,
  });

  /// Json for api integration

  factory Tomorrow.fromJson(Map<String, dynamic> json) {
    return Tomorrow(
      main: Source.fromJson(json["main"]),
      date: json["dt_txt"],
    );
  }
}

class Source {
  double? temp_min;
  double? temp_max;

  Source({this.temp_min, this.temp_max});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      temp_min: json["temp_min"],
      temp_max: json["temp_max"],
    );
  }
}
