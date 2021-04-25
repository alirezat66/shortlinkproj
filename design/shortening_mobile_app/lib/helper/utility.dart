import 'package:flutter/material.dart';

class Utility {
  static void showErrorWithKey(String error,
      GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        error,
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).errorColor,
    );

    ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(snackBar);
  }

  static void showMessageWithKey(String error,
      GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        error,
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
    );

    ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(snackBar);
  }
}
