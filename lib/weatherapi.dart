import 'package:flutter/foundation.dart';
import 'package:weather_app/services/location_acces.dart';
import 'package:weather_app/weathermodel.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherDetails with ChangeNotifier {
  Weathermodel? _weatherdata;
  Weathermodel? get weatherdata => _weatherdata;

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
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=0b232f58afefb3008cf63b1a8b8f7de7";

    _isloading = true;
    var response = await http.get(Uri.parse(baseurl));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      final data = weathermodelFromJson(response.body);
      _weatherdata = data;
      _isloading = false;

      notifyListeners();
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}
