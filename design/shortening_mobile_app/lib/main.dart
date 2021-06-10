import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortening_mobile_app/data/service/short_code_service.dart';
import 'package:shortening_mobile_app/screen/home_screen.dart';
import 'bloc/shortcode/short_code_cubit.dart';
import 'constant/constant_colors.dart';
import 'constant/constant_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ShortCodeService service = ShortCodeService();
  runApp(MyApp(service: service));
}

class MyApp extends StatelessWidget {
  final ShortCodeService service;
  MyApp({this.service}); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HSLColor.fromAHSL(1, 180, 0.66, 0.49).toColor(), // cyan
        backgroundColor: HSLColor.fromAHSL(1, 0, 0, 0.75).toColor(), //gray
        buttonColor: HSLColor.fromAHSL(1, 180, 0.66, 0.49).toColor(), // cyan
        primaryColorDark:
            HSLColor.fromAHSL(1, 257, 0.27, 0.26).toColor(), //dark violet
        errorColor: HSLColor.fromAHSL(1, 0, 0.87, 0.67).toColor(), //red
        textTheme: TextTheme(
          headline1: GoogleFonts.poppins(
              fontSize: 95, fontWeight: FontWeight.w500, letterSpacing: -1.5),
          headline2: GoogleFonts.poppins(
              fontSize: 61, fontWeight: FontWeight.w500, letterSpacing: -0.5),
          headline3: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: ConstantColors.veryDarkViolet,
              height: 1.2),
          headline4: GoogleFonts.poppins(
              fontSize: 35, fontWeight: FontWeight.w700, letterSpacing: -0.5),
          headline5:
              GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700),
          headline6: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.15,
            fontSize: 15,
            height: 1.8,
            color: ConstantColors.grayishViolet,
          ),
          subtitle1: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle2: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.5),
          bodyText2: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.25),
          button: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 1.0),
          caption: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.4),
          overline: GoogleFonts.poppins(
              fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.5),
        ),
      ),
      initialRoute: Routes.homeScreen,
      routes: {
        Routes.homeScreen: (context) => BlocProvider(
            create: (context) => ShortCodeCubit(service), child: HomeScreen()),
      },
    );
  }
}
