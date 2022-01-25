import 'package:flutter/material.dart';

final Color color = Color(0xffa020f0);
const KlabelTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFF8D8E98),
);

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPressed, this.child});
  final IconData icon;
  final Function onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.grey,
        size: 13,
      ),
      onPressed: onPressed,
      elevation: 0.0,
      splashColor: Colors.grey,
    );
  }
}
