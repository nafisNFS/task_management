class WeatherModel {
  final double temperature;
  final String weather;

  WeatherModel({required this.temperature, required this.weather});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['current']['temperature_2m'],
      weather: json['current']['weathercode'].toString(), // You can map this to readable strings later
    );
  }
}
