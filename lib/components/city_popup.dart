import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityPopup extends StatefulWidget {
  @override
  _CityPopupState createState() => _CityPopupState();
}

class _CityPopupState extends State<CityPopup> {
  String _cityName;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      backgroundColor: Colors.deepOrange,
      title: Text("Change Location",style: TextStyle(color: Colors.white),),
      actions: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 60,
              width: 300,
              child: TextField(
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: "Please enter city name",
                  icon: Icon(Icons.location_on),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.white10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none),
                ),
                maxLines: 1,
                onChanged: (value) {
                 _cityName=value;
                },
              ),
            ),
            MaterialButton(
              child: Text("OK",style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.pop(context,_cityName);
              },
            ),
          ],
        ),
      ],
    );
  }
}
