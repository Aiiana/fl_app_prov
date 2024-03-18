import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr_app_weather/dio_settings.dart';
import 'package:pr_app_weather/weather_model.dart';

class GetWeatherProvider extends ChangeNotifier {
  WeatherModel model = WeatherModel();

  bool isLoading = false;

  Future<void> getWeather({String? cityName}) async {
    isLoading = true;
    notifyListeners();
    final Dio dio = DioSettings().dio;
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?q=${cityName ?? 'Bishkek'}&appid=99e8a0fe0e835bd24d899cd8d3a93d2e&units=metric',
    );
    model = WeatherModel.fromJson(response.data);
    isLoading = false;
    notifyListeners();
  }
}
