import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/components/theme_bloc.dart';
import 'package:weather/screens/location_screen.dart';
import 'package:weather/services/networking.dart';
import 'package:weather/services/weather.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  static ThemeBloc themeBloc;
  final Future<Weather> post;

  const Home({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = ThemeBloc();
    return StreamBuilder<ThemeData>(
      initialData: themeBloc.initialTheme().data,
      stream: themeBloc.themeDataStream,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          theme: snapshot.data,
          home: LocationScreen(
            post: post ?? NetworkHelper.getLocationWeather(),
            themeBloc: themeBloc,
          ),
        );
      },
    );
  }
}
