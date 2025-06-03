import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiKey = 'f2c1d2a4705e6bbfcc8592761d337208';

  Future<Map<String, dynamic>?> fetchWeatherData() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';

      final response = await _dio.get(url);
      final data = response.data;
      final temp = data['main']['temp'];
      final city = data['name'];
      final icon = data['weather'][0]['icon'];

      return {
        'temp': temp.toDouble(),
        'city': city,
        'icon': icon,
      };
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }
}
