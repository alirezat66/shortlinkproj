import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_colors.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';
import 'package:shortening_mobile_app/widget/rounded_button_widget.dart';

class LinkItem extends StatelessWidget {
  final ShortCodeLink item;
  final Function onPressed;
  const LinkItem({
    Key key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: ConstantSize.normalPadding,
          left: ConstantSize.normalPadding,
          right: ConstantSize.normalPadding),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ConstantSize.extraSmallRadius)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: ConstantSize.semiSmallPadding,
                horizontal: ConstantSize.smallPadding),
            child: Text(
              item.originalLink,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: ConstantColors.veryDarkViolet),
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).backgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: ConstantSize.semiSmallPadding,
                horizontal: ConstantSize.smallPadding),
            child: Text(
              item.fullShortLink,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: ConstantSize.smallPadding,
                left: ConstantSize.smallPadding,
                bottom: ConstantSize.smallPadding),
            child: RoundedButton(
                onPressed: onPressed,
                height: ConstantSize.copyButtonHeight,
                width: MediaQuery.of(context).size.width,
                radius: ConstantSize.extraSmallRadius,
                color:
                    item.isCopied ? Theme.of(context).primaryColorDark : null,
                fontSize: 14,
                text: item.isCopied
                    ? StringValue.copiedButtonText
                    : StringValue.copyButtonText),
          )
        ]),
      ),
    );
  }
}
