import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shortening_mobile_app/constant/constant_colors.dart';
import 'package:shortening_mobile_app/constant/constant_images.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: SvgPicture.asset(
                      ImageAddress.headerImage,
                      fit: BoxFit.fitHeight,
                      height: size.height / 3,
                      alignment: Alignment.topRight,
                    ),
                    transform:
                        Matrix4.translationValues(size.width / 3, 0, 0.0),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: AutoSizeText(StringValue.homeTitle,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            color: ConstantColors.veryDarkViolet, height: 1.2)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: AutoSizeText(StringValue.homeDescription,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: ConstantColors.grayishViolet, height: 1.5)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(StringValue.startButton,
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: Size(size.width / 2, 50),
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 90,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.bars,
                color: ConstantColors.grayishViolet,
                size: 22,
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset('images/logo.svg'),
        ));
  }
}
