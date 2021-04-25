import 'package:flutter/material.dart';

class NavigationTextItem extends StatelessWidget {
  final Function onPressed;
  final String text;
  const NavigationTextItem({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
