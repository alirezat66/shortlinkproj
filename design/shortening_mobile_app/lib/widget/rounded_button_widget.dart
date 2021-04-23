import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double radius;
  final String text;
  const RoundedButton(
      {Key key,
      @required this.onPressed,
      @required this.width,
      @required this.radius,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text,
          style:
              Theme.of(context).textTheme.button.copyWith(color: Colors.white)),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: Size(width, ConstantSize.buttonHeight),
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          )),
    );
  }
}
