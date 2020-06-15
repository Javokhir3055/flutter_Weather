import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:weather/components/custom_app_bar.dart';
import 'package:weather/components/double_text.dart';
import 'package:weather/components/theme_bloc.dart';
import 'package:weather/services/picker.dart';
import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';
import 'package:weather/services/weather.dart';
import 'no_connecion_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  Future<Weather> post;
  final ThemeBloc themeBloc;
  LocationScreen({Key key, @required this.post, this.themeBloc})
      : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Completer<GoogleMapController> _controller = Completer();
  SnappingSheetController sheetController = SnappingSheetController();

  void updatePage() {
    setState(() {
      widget.post = NetworkHelper.getLocationWeather();
    });
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    updatePage();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
  }

  void onMapCreated(controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapHeight=MediaQuery.of(context).size.height*0.7;
    return Scaffold(
      appBar: CustomAppBar(
        themeBloc: widget.themeBloc,
      ),
      body: SafeArea(
          child: FutureBuilder<Weather>(
        future: widget.post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SnappingSheet(
              snapPositions: [
                SnapPosition(positionPixel: 0),
                SnapPosition(positionPixel: mapHeight),
              ],
              grabbingHeight: 60,
              child: SmartRefresher(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          snapshot.data.city.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 36,
                              color: Colors.blueAccent),
                        ),
                      ],
                    ),
                    Text(
                      snapshot.data.weatherData[0].main.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                    Image.asset(
                      iconWeather(snapshot.data.weatherData[0].icon),
                      height: 160,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.ideographic,
                      children: <Widget>[
                        Text(
                          snapshot.data.temp.toInt().toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 65,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          "॰",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 60,
                              color: Colors.blueAccent),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      child: Table(
                        children: [
                          TableRow(children: [
                            DoubleText(
                              textAbove: "wind speed",
                              textBelow:
                                  snapshot.data.windSpeed.toString() + " m/s",
                            ),
                            DoubleText(
                              textAbove: "humidity",
                              textBelow:
                                  snapshot.data.humidity.toString() + "%",
                            ),
                          ]),
                          TableRow(children: [
                            DoubleText(
                              textAbove: "sunrise",
                              textBelow: DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.data.sunriseTime * 1000,
                                  ).hour.toString() +
                                  ":" +
                                  DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.data.sunriseTime * 1000,
                                  ).minute.toString(),
                            ),
                            DoubleText(
                              textAbove: "sunset",
                              textBelow: DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.data.sunsetTime * 1000,
                                  ).hour.toString() +
                                  ":" +
                                  DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.data.sunsetTime * 1000,
                                  ).minute.toString(),
                            ),
                          ]),
                        ],
                      ),
                      padding: EdgeInsets.only(bottom: 30),
                    ),
                  ],
                ),
                enablePullDown: true,
                header: ClassicHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
              ),
              sheetBelow: Container(
                color: Colors.white,
                child: Stack(children: [
                  Positioned(
                    height: mapHeight,
                    left: 0,
                    right: 0,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(Location.latitude, Location.longitude),
                          zoom: 18),
//                  markers: ,
                      myLocationEnabled: true,
                      onMapCreated: onMapCreated,
                    ),
                  ),
                ]),
              ),
              grabbing: Container(
                height: 20,
                decoration: ShapeDecoration(
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)))),
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "See in Map",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return NoConnectionScreen();
          }
          return Center(
            child: SpinKitWave(
              size: 100.0,
              color: Colors.blue,
            ),
          );
        },
      )),
    );
  }
}
