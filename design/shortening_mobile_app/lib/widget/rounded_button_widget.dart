import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double radius;
  final String text;
  final double height;
  final double fontSize;
  final Color color;
  const RoundedButton(
      {Key key,
      @required this.onPressed,
      @required this.width,
      @required this.height,
      @required this.radius,
      this.color,
      this.fontSize,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = fontSize ?? 20;
    Color buttonColor = color ?? Theme.of(context).primaryColor;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Colors.white, fontSize: defaultSize)),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(width, height),
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          )),
    );
  }
}
