/// Model for weather forecast

class Weather {
  double? temp;
  double? wind;
  int? humidity;
  double? feels_like;
  int? pressure;
  String? description;
  double? temp_min;
  double? temp_max;
  String? city;
  double? lat;
  double? lon;
  String? dates;
  Source? main;
  City1? place;
  String? date;
  Weather1? wea;
  Wind1? win;
  double? temp1;
  double? temp2;
  double? temp3;
  double? temp4;

  Weather({
    this.temp,
    this.wind,
    this.humidity,
    this.feels_like,
    this.pressure,
    this.description,
    this.lat,
    this.lon,
    this.temp_min,
    this.temp_max,
    this.dates,
    this.date,
    this.main,
    this.city,
    this.place,
    this.wea,
    this.win,
    this.temp1,
    this.temp2,
    this.temp3,
    this.temp4,
  });

  /// Json for api
  Weather.fromJson(Map<String, dynamic> json) {
    temp = json["list"][0]["main"]["temp"];
    wind = json["list"][0]["wind"]["speed"];
    pressure = json["list"][0]["main"]["pressure"];
    humidity = json["list"][0]["main"]["humidity"];
    feels_like = json["list"][0]["main"]["feels_like"];
    description = json["list"][0]["weather"][0]["description"];
    city = json["city"]["name"];
    lat = json["city"]["coord"]["lat"];
    lon = json["city"]["coord"]["lon"];
    temp_min = json["list"][0]["main"]["temp_min"];
    temp_max = json["list"][0]["main"]["temp_max"];
    dates = json["list"][0]["dt_txt"];
    temp1 = json["list"][2]["main"]["temp"];
    temp2 = json["list"][3]["main"]["temp"];
    temp3 = json["list"][4]["main"]["temp"];
    temp4 = json["list"][5]["main"]["temp"];
  }

  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
      main: Source.fromJson(json["main"]),
      date: json["dt_txt"],
      place: City1.fromjson(json["city"]),
      wea: Weather1.fromjson(json["weather"]),
      win: Wind1.fromjson(json["wind"]),
    );
  }

  factory Weather.fromson(Map<String, dynamic> json) {
    return Weather(
      main: Source.fromJson(json["main"]),
      date: json["dt_txt"],
    );
  }
}

class Source {
  double? temp_min;
  double? temp_max;
  int? pressure;
  int? humidity;
  double? feels_like;
  double? temp;

  Source(
      {this.temp_min,
      this.temp_max,
      this.pressure,
      this.humidity,
      this.feels_like,
      this.temp});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      temp_min: json["temp_min"],
      temp_max: json["temp_max"],
      pressure: json["humidity"],
      humidity: json["pressure"],
      feels_like: json["feels_like"],
      temp: json["temp"],
    );
  }
}

class City1 {
  String? city;
  double? lat;
  double? lon;

  City1({this.city, this.lat, this.lon});

  factory City1.fromjson(Map<String, dynamic> json) {
    return City1(
      city: json["city"],
      lat: json["coord"]["lat"],
      lon: json["coord"]["lon"],
    );
  }
}

class Weather1 {
  String? description;
  Weather1({this.description});
  factory Weather1.fromjson(Map<String, dynamic> json) {
    return Weather1(
      description: json["description"],
    );
  }
}

class Wind1 {
  double? speed;
  Wind1({this.speed});
  factory Wind1.fromjson(Map<String, dynamic> json) {
    return Wind1(
      speed: json["speed"],
    );
  }
}
