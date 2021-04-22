import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/screen/home_screen.dart';

import 'constant/constant_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortly',
      theme: ThemeData(
        primaryColor: HSLColor.fromAHSL(1, 180, 0.66, 0.49).toColor(), // cyan
        backgroundColor: HSLColor.fromAHSL(1, 0, 0, 0.75).toColor(), //gray
        buttonColor: HSLColor.fromAHSL(1, 180, 0.66, 0.49).toColor(), // cyan
        primaryColorDark:
            HSLColor.fromAHSL(1, 257, 0.27, 0.26).toColor(), //dark violet
        errorColor: HSLColor.fromAHSL(1, 0, 0.87, 0.67).toColor(), //red
      ),
      initialRoute: Routes.homeScreen,
      routes: {
        Routes.homeScreen: (context) => HomeScreen(),
      },
    );
  }
}
