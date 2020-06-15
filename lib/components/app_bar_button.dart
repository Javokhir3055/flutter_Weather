import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key key,
    this.onPressed,
    this.icon,
  }) : super(key: key);
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
    minWidth: 5,
      child: Icon(

        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
