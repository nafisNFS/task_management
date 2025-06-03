import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = WeatherService();

  var temperature = 0.0.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var city = 'Dhaka'.obs;
  var iconCode = '01d'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTemperature();
  }

  void fetchTemperature() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _weatherService.fetchWeatherData(); // <- Adjust based on your API
      if (result != null) {
        temperature.value = result['temp'];
        city.value = result['city'];
        iconCode.value = result['icon'];
      } else {
        errorMessage.value = 'Failed to load temperature';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
