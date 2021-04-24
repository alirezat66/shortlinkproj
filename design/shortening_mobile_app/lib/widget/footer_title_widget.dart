import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';

class FooterTitle extends StatelessWidget {
  final String text;
  const FooterTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ConstantSize.smallPadding - 2),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .caption
            .copyWith(color: Colors.white, fontSize: 16, letterSpacing: 0.0),
      ),
    );
  }
}
