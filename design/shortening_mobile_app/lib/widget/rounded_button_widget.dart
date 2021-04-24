import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double radius;
  final String text;
  final double height;
  final double fontSize;
  const RoundedButton(
      {Key key,
      @required this.onPressed,
      @required this.width,
      @required this.height,
      @required this.radius,
      this.fontSize,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = fontSize ?? 20;
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
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          )),
    );
  }
}
