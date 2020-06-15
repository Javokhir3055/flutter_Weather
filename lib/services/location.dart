import 'package:geolocator/geolocator.dart';

class Location {
  static double _latitude;
  static double _longitude;

  static Future<void> getCurrentPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    _latitude = position.latitude;
    _longitude = position.longitude;
  }

  static double get latitude => _latitude;

  static double get longitude => _longitude;

  static set latitude(latitude) => _latitude=latitude;

  static set longitude (double longitude)=> _longitude=longitude;

}
