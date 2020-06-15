import 'package:flutter/material.dart';
import 'package:weather/utilities/constants.dart';

class DoubleText extends StatefulWidget {
  final String textAbove;
  final String textBelow;

  const DoubleText({Key key, this.textAbove, this.textBelow}) : super(key: key);

  @override
  _DoubleTextState createState() => _DoubleTextState();
}

class _DoubleTextState extends State<DoubleText> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[Text(widget.textAbove,style: kAboveText,), Text(widget.textBelow,style: kBelowText,)],
    );
  }
}
