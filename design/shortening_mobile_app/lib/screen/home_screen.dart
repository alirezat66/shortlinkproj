import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shortening_mobile_app/constant/constant_colors.dart';
import 'package:shortening_mobile_app/constant/constant_images.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/advance_note.dart';
import 'package:shortening_mobile_app/widget/advance_item_widget.dart';
import 'package:shortening_mobile_app/widget/advance_note_list_view_widget.dart';
import 'package:shortening_mobile_app/widget/rounded_button_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _shortenLinkKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<AdvanceNote> advanceNoteList = AdvanceNoteList().list;
    final _shortLinkTextController = TextEditingController();

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    buildFirstPage(size, context),
                    buildSecondPage(size, context, advanceNoteList),
                  ],
                ),
                Positioned(
                  top: size.height -
                      ConstantSize.toolbarHeight -
                      ConstantSize.homeScreenInputFormHeight / 2.5,
                  child: buildInputLinkPart(
                      size, context, _shortLinkTextController),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildSecondPage(
      Size size, BuildContext context, List<AdvanceNote> advanceNoteList) {
    return Container(
      color: ConstantColors.grayBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: ConstantSize.largePadding * 3,
                left: ConstantSize.largePadding,
                right: ConstantSize.largePadding),
            child: AutoSizeText(StringValue.advancedTitle,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: ConstantColors.veryDarkViolet, height: 1.2)),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: ConstantSize.smallPadding,
                left: ConstantSize.largePadding,
                right: ConstantSize.largePadding),
            child: AutoSizeText(StringValue.advancedDescription,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: ConstantColors.grayishViolet, height: 1.5)),
          ),
          SizedBox(
            height: ConstantSize.extraLargePadding,
          ),
          AdvanceNoteListView(list: advanceNoteList),
          SizedBox(
            height: size.height / 10,
          ),
        ],
      ),
    );
  }

  Container buildFirstPage(Size size, BuildContext context) {
    return Container(
      height: size.height - ConstantSize.toolbarHeight,
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
            transform: Matrix4.translationValues(size.width / 3, 0, 0.0),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: ConstantSize.largePadding,
                left: ConstantSize.largePadding,
                right: ConstantSize.largePadding),
            child: AutoSizeText(StringValue.homeTitle,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: ConstantColors.veryDarkViolet, height: 1.2)),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: ConstantSize.smallPadding,
                left: ConstantSize.smallPadding,
                right: ConstantSize.smallPadding),
            child: AutoSizeText(StringValue.homeDescription,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: ConstantColors.grayishViolet, height: 1.5)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: ConstantSize.largePadding),
            child: RoundedButton(
              text: StringValue.startButton,
              onPressed: _onClickStartButton,
              radius: ConstantSize.largeRadius,
              width: size.width / 2,
            ),
          ),
        ],
      ),
    );
  }

  ConstrainedBox buildInputLinkPart(Size size, BuildContext context,
      TextEditingController _shortLinkTextController) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: size.width - ConstantSize.extraLargePadding,
        minHeight: ConstantSize.homeScreenInputFormHeight,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstantSize.smallRadius),
            color: Theme.of(context).primaryColorDark),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(ConstantSize.smallRadius)),
                  child: SvgPicture.asset(ImageAddress.backgroundShortenMobile),
                )),
            Form(
              key: _shortenLinkKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: ConstantSize.largePadding),
                child: Column(children: [
                  Container(
                    width: size.width - ConstantSize.extraLargePadding * 2,
                    child: TextFormField(
                      controller: _shortLinkTextController,
                      onChanged: _onChangedLinkText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please add a link';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.fromLTRB(
                              ConstantSize.smallPadding,
                              ConstantSize.extraSmallPadding,
                              ConstantSize.smallPadding,
                              ConstantSize.extraSmallPadding),
                          filled: true,
                          hintText: 'Shorten a link here',
                          hintStyle:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontSize: 14,
                                    color: ConstantColors.grayishViolet,
                                  ),
                          errorStyle:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context).errorColor,
                                  ),
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ConstantSize.smallRadius),
                              borderSide: new BorderSide(
                                color: Colors.white,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: ConstantSize.normalPadding,
                  ),
                  RoundedButton(
                      text: StringValue.shortenButton,
                      onPressed: _shortenLink,
                      width: size.width - ConstantSize.extraLargePadding * 2,
                      radius: ConstantSize.smallRadius)
                ]),
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
        toolbarHeight: ConstantSize.toolbarHeight,
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

  void _onClickStartButton() {
    //todo on click on start button
  }

  _shortenLink() {
    final isValid = _shortenLinkKey.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  void _onChangedLinkText(String value) {
    if (value.isNotEmpty) _shortenLinkKey.currentState.validate();
  }
}
