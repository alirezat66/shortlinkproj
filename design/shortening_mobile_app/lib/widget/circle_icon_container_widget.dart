import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shortening_mobile_app/constant/constant_colors.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';

class CircleIconContainer extends StatelessWidget {
  final String iconAddress;
  const CircleIconContainer({
    Key key,
    @required this.iconAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConstantSize.circleIconContainerSize,
      height: ConstantSize.circleIconContainerSize,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(ConstantSize.circleIconContainerSize / 2),
        color: Theme.of(context).primaryColorDark,
      ),
      child: SvgPicture.asset(
        iconAddress,
        width: ConstantSize.circleIconContainerSize / 2,
        height: ConstantSize.circleIconContainerSize / 2,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
