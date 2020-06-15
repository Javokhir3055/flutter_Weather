import 'package:flutter/material.dart';

String iconWeather(String iconCode) {
  switch (iconCode) {
    case '01d':
    //clear sky
      return 'images/clear_sky_day.png';
    case '02d':
    //few clouds
      return 'images/few_clouds_day.png';
    case '03d':
    //scattered clouds
      return 'images/scattered_clouds_day.png';
    case '04d':
    //broken clouds
      return 'images/broken_clouds_day.png';
    case '09d':
    //shower rain
      return 'images/shower_rain_day.png';
    case '10d':
    //rain
      return 'images/rain_day.png';
    case '11d':
    //thunderstorm
      return 'images/thunderstorm_day.png';
    case '13d':
    //snow
      return 'images/snow_day.png';
    case '50d':
    //mist
      return 'images/mist_day.png';
    case '01n':
    //clear sky
      return 'images/clear_sky_night.png';
    case '02n':
    //few clouds
      return 'images/few_clouds_night.png';
    case '03n':
    //scattered clouds
      return 'images/scattered_clouds_day.png';
    case '04n':
    //broken clouds
      return 'images/broken_clouds_day.png';
    case '09n':
    //shower rain
      return 'images/shower_rain_day.png';
    case '10n':
    //rain
      return 'images/rain_day.png';
    case '11n':
    //thunderstorm
      return 'images/thunderstorm_night.png';
    case '13n':
    //snow
      return 'images/snow_day.png';
    case '50n':
    //mist
      return 'images/mist_day.png';

    default:
      return 'images/default.svg';
  }
}

isDarkMode(bool isDarkMode) {
  if (isDarkMode)
    return ThemeData.dark();
  else
    return ThemeData.light();
}