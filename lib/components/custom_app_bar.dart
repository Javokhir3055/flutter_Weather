import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/components/city_popup.dart';
import 'package:weather/components/theme_bloc.dart';
import 'package:weather/main.dart';
import 'package:weather/components/settings_popup.dart';
import 'package:weather/services/networking.dart';

import 'app_bar_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({Key key, this.themeBloc}) : super(key: key);
  final ThemeBloc themeBloc;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 90),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
            ),
          ),
          backgroundColor: Colors.amber,
          actions: [
            AppBarButton(
                icon: Icons.refresh,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, a1, a2) => Home(

                            )),
                  );
                }),
            AppBarButton(
              icon: Icons.my_location,
              onPressed: () {
                showDialog(context: context, builder: (context) => CityPopup())
                    .then((cityName) {
                  if (cityName != null) {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, a1, a2) => Home(
                              post: NetworkHelper.getCityWeather(cityName),
                                )));
                  }
                });
              },
            ),
            AppBarButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SettingsPopup(    themeBloc: themeBloc,));
                },
                icon: Icons.settings)
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => null;

  @override
  Size get preferredSize => Size.fromHeight(60);
}
