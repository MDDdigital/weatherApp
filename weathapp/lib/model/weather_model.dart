class Weather {
  String? cityname;
  double? temp;
  double? wind;
  int? humidity;
  double? feels_like;
  int? pressure;

  Weather({
    this.cityname,
    this.temp,
    this.wind,
    this.humidity,
    this.feels_like,
    this.pressure,
  });

//now let's build a function to parse the JSON file into the model

  Weather.fromJson(Map<String, dynamic> json) {
    cityname = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    feels_like = json["main"]["feels_like"];
  }
}
