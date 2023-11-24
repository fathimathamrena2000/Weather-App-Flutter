import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:weather_app/forecastmodel.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/forecast_weather_model.dart';
import 'package:weather_app/services/location_acces.dart';

class ForecastDetails with ChangeNotifier {
  ForecastWeatherModel? _forecastdata;
  ForecastWeatherModel? get forecastdata => _forecastdata;

  bool _isloading = false;
  bool get isloading => _isloading;
  LocationFetcher locationFetcher = LocationFetcher();

  Future<void> fetchData() async {
    await locationFetcher.determinePosition(); //custom class
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    final latitude = position.latitude;
    final longitude = position.longitude;
    String baseurl =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=0b232f58afefb3008cf63b1a8b8f7de7&units=imperial";

    _isloading = true;
    var response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      final data = ForecastWeatherModel.fromJson(json.decode(response.body));
      _forecastdata = data;
      _isloading = false;

      notifyListeners();
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
