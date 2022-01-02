/// Model for today weather

class Today {
  Source? main;
  String? date;

  Today({
    this.main,
    this.date,
  });

  ///Json for api integration

  factory Today.fromJson(Map<String, dynamic> json) {
    return Today(
      main: Source.fromJson(json["main"]),
      date: json["dt_txt"],
    );
  }
}

class Source {
  int? humidity;
  double? temp_max;

  Source({this.humidity, this.temp_max});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      humidity: json["humidity"],
      temp_max: json["temp_max"],
    );
  }
}
