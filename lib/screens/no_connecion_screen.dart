import 'package:flutter/material.dart';
import 'package:weather/screens/location_screen.dart';
import 'package:weather/services/networking.dart';

class NoConnectionScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NoConnectionScreen> {
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(180),
              child: Image.asset(
                'images/no_connection.jpg',
              ),
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, a1, a2) => LocationScreen(
                              post: NetworkHelper.getLocationWeather(),
                            )),
                  );
                });
              },
              height: 10,
              child: Text('Try Again'),
            ),
          )
        ],
      ),
    );
  }
}
