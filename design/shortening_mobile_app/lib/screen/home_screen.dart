import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:shortening_mobile_app/data/model/footer_menu.dart';
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
    List<FooterMenu> _footerList = StringValue.footerMenu;
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
                      kToolbarHeight -
                      ConstantSize.homeScreenInputFormHeight / 2.5,
                  child: buildInputLinkPart(
                      size, context, _shortLinkTextController),
                ),
              ],
            ),
            buildBoostPart(size, context),
            buildFooterPart(size, _footerList)
          ],
        ),
      ),
    );
  }

  Container buildFooterPart(Size size, List<FooterMenu> menu) {
    return Container(
        width: size.width,
        color: ConstantColors.veryDarkViolet,
        child: Column(
          children: [
            SizedBox(
              height: ConstantSize.largePadding,
            ),
            SvgPicture.asset(
              ImageAddress.logoImage,
              color: Colors.white,
            ),
            SizedBox(
              height: ConstantSize.largePadding,
            ),
            FooterList(menu: menu),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebookSquare,
                          color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon:
                          FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.pinterest,
                          color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram,
                          color: Colors.white),
                      onPressed: () {}),
                ]),
            SizedBox(
              height: ConstantSize.extraLargePadding,
            ),
          ],
        ));
  }

  Container buildBoostPart(Size size, BuildContext context) {
    return Container(
      width: size.width,
      height: 300,
      color: Theme.of(context).primaryColorDark,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SvgPicture.asset(ImageAddress.backgroundBoostMobile),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: ConstantSize.largePadding,
                      right: ConstantSize.largePadding),
                  child: AutoSizeText('Boosts your links today',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.white, height: 1.5)),
                ),
                SizedBox(height: ConstantSize.normalPadding),
                buildStartButton(size),
              ]),
            ],
          )
        ],
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
      height: size.height - kToolbarHeight,
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
            child: buildStartButton(size),
          ),
        ],
      ),
    );
  }

  RoundedButton buildStartButton(Size size) {
    return RoundedButton(
      text: StringValue.startButton,
      onPressed: _onClickStartButton,
      radius: ConstantSize.largeRadius,
      width: size.width / 2,
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
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(ImageAddress.logoImage),
            ),
          ],
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

class FooterList extends StatelessWidget {
  final List<FooterMenu> menu;
  const FooterList({
    Key key,
    @required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: FooterTitleText(
              text: menu[index].title,
            ),
            subtitle: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: menu[index].subStrings.length,
                itemBuilder: (context, subIndex) {
                  return FooterSubTitleText(
                      text: menu[index].subStrings[subIndex]);
                }),
          );
        });
  }
}

class FooterSubTitleText extends StatelessWidget {
  final String text;
  const FooterSubTitleText({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ConstantSize.extraSmallPadding),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.overline.copyWith(
              color: ConstantColors.grayishViolet,
            ),
      ),
    );
  }
}

class FooterTitleText extends StatelessWidget {
  final String text;
  const FooterTitleText({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ConstantSize.smallPadding),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
      ),
    );
  }
}
