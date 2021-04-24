import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';

class FooterSubTitle extends StatelessWidget {
  final String text;
  const FooterSubTitle({
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
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).backgroundColor,
              letterSpacing: -0.25,
            ),
      ),
    );
  }
}
