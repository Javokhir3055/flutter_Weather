import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather/exceptions/location_exception.dart';
import 'package:weather/utilities/constants.dart';

import 'location.dart';
import 'weather.dart';

class NetworkHelper {
  static String _url;

  static Future<Weather> _fetchData() async {
    var response = await http.get(_url);

    if (response.statusCode == 200) {
      String data = response.body;
      print("$_url is connected");
      return Weather.fromJson(json.decode(data));
    } else {
      print("$_url is not connected");
      throw HttpException("404");
    }
  }

  static Future<Weather> getCityWeather(String city) async {
    _url = "$kUrl\q=$city&appid=$kApiKey&units=metric";
    return await NetworkHelper._fetchData();
  }

  static Future<Weather> getLocationWeather() async {
    try {
      await Location.getCurrentPosition();
      if (Location.longitude == null || Location.latitude == null)
        throw LocationException("No Access to Geoloaction");

      _url = kUrl +
          "lat=${Location.latitude}&lon=${Location.longitude}&appid=" +
          kApiKey +
          "&units=metric";
    } catch (LocationException) {
      //TODO:PopUp window
      print("Null data from JSON");

      Location.latitude = 41.311081;
      Location.longitude = 69.240562;
      _url = kUrl +
          "lat=${Location.latitude}&lon=${Location.longitude}&appid=" +
          kApiKey +
          "&units=metric";
    }
    return await NetworkHelper._fetchData();
  }
}
