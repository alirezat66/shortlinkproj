import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shortening_mobile_app/bloc/shortcode/short_code_cubit.dart';
import 'package:shortening_mobile_app/constant/constant_colors.dart';
import 'package:shortening_mobile_app/constant/constant_images.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/advance_note.dart';
import 'package:shortening_mobile_app/data/model/footer_menu.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';
import 'package:shortening_mobile_app/widget/advance_note_list_view_widget.dart';
import 'package:shortening_mobile_app/widget/footer_list_widget.dart';
import 'package:shortening_mobile_app/widget/link_item_widget.dart';
import 'package:shortening_mobile_app/widget/loading_dialog.dart';
import 'package:shortening_mobile_app/widget/rounded_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _shortenLinkKey = GlobalKey<FormState>();
  ShortCodeCubit _shortCodeCubit;
  final _shortLinkTextController = TextEditingController();
  BuildContext dialogContext;
  ShortCodeLinkList _shortCodeList = ShortCodeLinkList();
  @override
  void initState() {
    _shortCodeCubit = context.read<ShortCodeCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<AdvanceNote> advanceNoteList = AdvanceNoteList().list;
    List<FooterMenu> _footerList = StringValue.footerMenu;

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: BlocListener<ShortCodeCubit, ShortCodeState>(
        listener: (context, state) {
          if (state is ShortCodeLoading) {
            _showWaitingDialog();
          } else {
            if (state is ShortCodeError) {
              //todo show error
              _disMissDialog();
            } else if (state is ShortCodeUrlDone) {
              setState(() {
                _shortCodeList.links.add(state.link);
                _shortLinkTextController.text = '';
              });
              _disMissDialog();
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      buildHomePage(size, context),
                      buildAdvancedPage(size, context, advanceNoteList),
                    ],
                  ),
                  Positioned(
                    top: size.height +
                        kToolbarHeight / 2 -
                        ConstantSize.homeScreenInputFormHeight / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: ConstantSize.extraSmallPadding),
                      child: buildInputLinkPart(size, context),
                    ),
                  ),
                ],
              ),
              buildBoostPart(size, context),
              buildFooterPart(size, _footerList)
            ],
          ),
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
              height: ConstantSize.extraLargePadding + 6,
            ),
            SvgPicture.asset(
              ImageAddress.logoImage,
              color: Colors.white,
            ),
            SizedBox(
              height: ConstantSize.extraLargePadding - 4,
            ),
            FooterList(menu: menu),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSize.extraSmallPadding * 3),
                child: SvgPicture.asset(ImageAddress.faceBookIcon),
              )),
              GestureDetector(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSize.extraSmallPadding * 3),
                child: SvgPicture.asset(ImageAddress.twitterIcon),
              )),
              GestureDetector(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSize.extraSmallPadding * 3),
                child: SvgPicture.asset(ImageAddress.pinterestIcon),
              )),
              GestureDetector(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSize.extraSmallPadding * 3),
                child: SvgPicture.asset(ImageAddress.instagramIcon),
              )),
            ]),
            SizedBox(
              height: ConstantSize.smallPadding,
            ),
          ],
        ));
  }

  Container buildBoostPart(Size size, BuildContext context) {
    return Container(
      width: size.width,
      height: ConstantSize.boostPartHeight,
      color: Theme.of(context).primaryColorDark,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SvgPicture.asset(ImageAddress.backgroundBoostMobile),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                Text(StringValue.boostTitle,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontSize: 28, height: 1.5)),
                SizedBox(height: ConstantSize.smallPadding),
                buildStartButton(size),
              ]),
            ],
          )
        ],
      ),
    );
  }

  Container buildAdvancedPage(
      Size size, BuildContext context, List<AdvanceNote> advanceNoteList) {
    return Container(
      color: ConstantColors.grayBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          ListView.builder(
            itemCount: _shortCodeList.links.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return LinkItem(
                item: _shortCodeList.links[index],
                onPressed: () {},
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(
                top: _shortCodeList.links.length == 0
                    ? ConstantSize.largePadding * 3
                    : ConstantSize.largePadding * 2,
                left: ConstantSize.normalPadding * 2 - 1,
                right: ConstantSize.normalPadding * 2 - 1),
            child: Text(StringValue.advancedTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: ConstantColors.veryDarkViolet,
                    fontSize: 28,
                    height: 1.2)),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: ConstantSize.smallPadding,
                left: ConstantSize.semiLargePadding,
                right: ConstantSize.semiLargePadding),
            child: Text(StringValue.advancedDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(letterSpacing: 0.5, height: 1.9)),
          ),
          SizedBox(
            height: ConstantSize.extraLargePadding,
          ),
          AdvanceNoteListView(list: advanceNoteList),
          SizedBox(
            height: ConstantSize.extraLargePadding - 2,
          ),
        ],
      ),
    );
  }

  Container buildHomePage(Size size, BuildContext context) {
    return Container(
      height: size.height + kToolbarHeight / 2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SvgPicture.asset(
              ImageAddress.headerImage,
              alignment: Alignment.topRight,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: ConstantSize.semiLargePadding,
                    left: ConstantSize.largePadding +
                        ConstantSize.normalPadding / 4,
                    right: ConstantSize.largePadding +
                        ConstantSize.normalPadding / 4),
                child: AutoSizeText(StringValue.homeTitle,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    maxFontSize: 48,
                    style: Theme.of(context).textTheme.headline3),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: ConstantSize.extraSmallPadding * 3,
                    left: ConstantSize.largePadding,
                    right: ConstantSize.largePadding),
                child: AutoSizeText(StringValue.homeDescription,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: ConstantColors.grayishViolet,
                        letterSpacing: -0.5,
                        height: 1.6)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: ConstantSize.largePadding),
                child: buildStartButton(size),
              ),
            ],
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
      height: ConstantSize.roundedButtonHeight,
      width: size.width -
          ConstantSize.semiLargePadding * 4 -
          ConstantSize.semiSmallPadding,
    );
  }

  ConstrainedBox buildInputLinkPart(
    Size size,
    BuildContext context,
  ) {
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
                    vertical: ConstantSize.normalPadding),
                child: Column(children: [
                  Container(
                    width: size.width - ConstantSize.extraLargePadding * 2,
                    child: TextFormField(
                      controller: _shortLinkTextController,
                      onChanged: _onChangedLinkText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return StringValue.emptyError;
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
                          hintText: StringValue.shortenLinkTextHint,
                          hintStyle:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontSize: 15,
                                    color: ConstantColors.grayishViolet,
                                  ),
                          errorStyle:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context).errorColor,
                                  ),
                          enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ConstantSize.smallRadius),
                              borderSide: new BorderSide(
                                color: Colors.white,
                              )),
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ConstantSize.smallRadius),
                              borderSide: new BorderSide(
                                color: Colors.white,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: ConstantSize.smallPadding,
                  ),
                  RoundedButton(
                      text: StringValue.shortenButton,
                      onPressed: _shortenLink,
                      fontSize: 18,
                      height: ConstantSize.buttonHeight,
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
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal:
                    ConstantSize.largePadding - ConstantSize.semiSmallPadding),
            child: Center(
              child: SvgPicture.asset(
                ImageAddress.menuImage,
                color: ConstantColors.grayishViolet,
                width: ConstantSize.menuIconSize,
                height: ConstantSize.menuIconSize,
              ),
            ),
          ),
        ],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: ConstantSize.semiSmallPadding),
              child: SvgPicture.asset(ImageAddress.logoImage),
            )
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
    } else {
      _shortCodeCubit.shortALink(_shortLinkTextController.text);
    }
  }

  void _onChangedLinkText(String value) {
    if (value.isNotEmpty) _shortenLinkKey.currentState.validate();
  }

  void _showWaitingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return LoadingDialog();
        });
  }

  void _disMissDialog() {
    Navigator.pop(dialogContext);
  }
}
