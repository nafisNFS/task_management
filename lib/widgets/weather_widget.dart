import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/weather_controller.dart';


class WeatherWidget extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final temp = weatherController.temperature.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.thermostat, color: Colors.redAccent),
          SizedBox(width: 8),
          Text(
            temp != null ? '${temp.toStringAsFixed(1)} °C' : 'Loading...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      );
    });
  }
}
