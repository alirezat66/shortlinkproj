import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
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
import 'package:shortening_mobile_app/data/model/short_code_link.dart';
import 'package:shortening_mobile_app/helper/utility.dart';
import 'package:shortening_mobile_app/widget/advance_note_list_view_widget.dart';
import 'package:shortening_mobile_app/widget/footer_list_widget.dart';
import 'package:shortening_mobile_app/widget/loading_dialog.dart';
import 'package:shortening_mobile_app/widget/rounded_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortening_mobile_app/widget/short_link_listview_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _shortenLinkKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  OverlayEntry _menuOverlay;
  ShortCodeCubit _shortCodeCubit;
  final _shortLinkTextController = TextEditingController();
  BuildContext dialogContext;
  ShortCodeLinkList _shortCodeList = ShortCodeLinkList();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Size size;
  @override
  void initState() {
    _shortCodeCubit = context.read<ShortCodeCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: buildAppBar(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocListener<ShortCodeCubit, ShortCodeState>(
        listener: (context, state) {
          if (state is ShortCodeLoading) {
            _showWaitingDialog();
          } else {
            if (state is ShortCodeError) {
              _disMissDialog();
              Utility.showErrorWithKey(state.error, _scaffoldKey, context);
            } else if (state is ShortCodeUrlDone) {
              setState(() {
                _shortCodeList.links.add(state.link);
                _shortLinkTextController.text = '';
              });
              _disMissDialog();
            }
          }
        },
        child: buildBody(context),
      ),
    );
  }

  SingleChildScrollView buildBody(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  buildHomePage(context),
                  buildAdvancedPage(context),
                ],
              ),
              Positioned(
                top: size.height +
                    kToolbarHeight / 2 -
                    ConstantSize.homeScreenInputFormHeight / 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: ConstantSize.extraSmallPadding),
                  child: buildInputLinkPart(context),
                ),
              ),
            ],
          ),
          buildBoostPage(context),
          buildFooterPage()
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (_menuOverlay != null) {
                  _disMissMenu();
                } else {
                  _showMenu(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstantSize.largePadding -
                        ConstantSize.semiSmallPadding),
                child: SvgPicture.asset(
                  ImageAddress.menuImage,
                  color: ConstantColors.grayishViolet,
                  width: ConstantSize.menuIconSize,
                  height: ConstantSize.menuIconSize,
                ),
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

  Container buildHomePage(BuildContext context) {
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
                    top: ConstantSize.semiLargePadding - 2,
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
                child: buildStartButton(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildAdvancedPage(BuildContext context) {
    return Container(
      color: ConstantColors.grayBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          ShortLinkListView(
            shortCodeList: _shortCodeList,
            onClick: (index) {
              _copyToClipBoard(index);
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
          AdvanceNoteListView(),
          SizedBox(
            height: ConstantSize.extraLargePadding - 2,
          ),
        ],
      ),
    );
  }

  ConstrainedBox buildInputLinkPart(BuildContext context) {
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

  Container buildBoostPage(BuildContext context) {
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
                buildStartButton(),
              ]),
            ],
          )
        ],
      ),
    );
  }

  Container buildFooterPage() {
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
            FooterList(),
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

  RoundedButton buildStartButton() {
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

  void _onClickStartButton() {
    _scrollController.animateTo(size.height - 100,
        duration: Duration(milliseconds: 800), curve: Curves.ease);
  }

  void _shortenLink() {
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

  void _copyToClipBoard(int index) {
    FlutterClipboard.copy(_shortCodeList.links[index].fullShortLink)
        .then((value) {
      setState(() {
        _shortCodeList.setAsCopiedByIndex(index);
      });
      Utility.showMessageWithKey(
          StringValue.copiedSuccessText, _scaffoldKey, context);
    });
  }

  void _showMenu(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    _menuOverlay = OverlayEntry(builder: (context) {
      return Positioned(
        top: kToolbarHeight +
            ConstantSize.extraLargePadding +
            ConstantSize.semiSmallPadding,
        right: ConstantSize.normalPadding,
        left: ConstantSize.normalPadding,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstantSize.smallRadius),
            color: Theme.of(context).primaryColorDark,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28),
                child: TextButton(
                  onPressed: () {
                    _disMissMenu();
                  },
                  child: Text(
                    'Features',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: ConstantSize.semiSmallPadding + 2),
                child: TextButton(
                  onPressed: () {
                    _disMissMenu();
                  },
                  child: Text(
                    'Pricing',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: ConstantSize.semiSmallPadding - 2),
                child: TextButton(
                  onPressed: () {
                    _disMissMenu();
                  },
                  child: Text(
                    'Resources',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: ConstantSize.semiNormalPadding,
                    right: ConstantSize.largePadding,
                    left: ConstantSize.largePadding),
                child: Divider(
                  height: 1,
                  color: ConstantColors.grayBackground.withOpacity(0.4),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: ConstantSize.normalPadding - 4),
                child: TextButton(
                  onPressed: () {
                    _disMissMenu();
                  },
                  child: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: ConstantSize.smallPadding - 4,
                    bottom: ConstantSize.semiLargePadding - 2,
                    right: ConstantSize.normalPadding,
                    left: ConstantSize.normalPadding),
                child: RoundedButton(
                    width: MediaQuery.of(context).size.width,
                    height: ConstantSize.buttonMenuHeight,
                    fontSize: 18,
                    radius: ConstantSize.largeRadius,
                    onPressed: () {
                      _disMissMenu();
                    },
                    text: 'Sign Up'),
              )
            ],
          ),
        ),
      );
    });
    overlayState.insert(_menuOverlay);
  }

  void _disMissMenu() {
    _menuOverlay.remove();
    _menuOverlay = null;
  }
}
