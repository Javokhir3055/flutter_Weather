import 'package:flutter/material.dart';
import 'package:weather/components/theme_bloc.dart';


class SettingsPopup extends StatefulWidget {
  final ThemeBloc themeBloc;

  const SettingsPopup({Key key, this.themeBloc}) : super(key: key);
  @override
  _SettingsPopupState createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  static bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      backgroundColor: Colors.deepOrange,
      title: Text(
        "Night mode",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        Switch(
          onChanged: (bool value) async {
            setState(() {
              _isDarkMode = value;
              if (_isDarkMode)
                 widget.themeBloc.selectedTheme.add(_buildDarkTheme());
              else
                widget.themeBloc.selectedTheme.add(_buildLightTheme());
            });
          },
          value: _isDarkMode,
        ),
      ],
    );
  }
  DemoTheme _buildLightTheme() {
    return DemoTheme(
        'light',
        ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.deepOrange,
          primaryColor: Colors.cyanAccent,
        ));
  }

  DemoTheme _buildDarkTheme() {
    return DemoTheme(
        'dark',
        ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.lightBlueAccent,
          primaryColor: Colors.pink,
        ));
  }
}
