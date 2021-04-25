import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';
import 'package:shortening_mobile_app/data/model/advance_note.dart';

import 'circle_icon_container_widget.dart';

class AdvanceItem extends StatelessWidget {
  final AdvanceNote note;
  const AdvanceItem({
    Key key,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Padding(
        padding: const EdgeInsets.only(
            top: ConstantSize.circleIconContainerSize / 2),
        child: Container(
          width: MediaQuery.of(context).size.width -
              ConstantSize.extraLargePadding,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(ConstantSize.extraSmallRadius)),
          child: Column(
            children: [
              SizedBox(height: 75),
              Text(
                note.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: ConstantSize.smallPadding - 2,
                    right: ConstantSize.largePadding +
                        ConstantSize.extraSmallPadding,
                    left: ConstantSize.largePadding +
                        ConstantSize.extraSmallPadding,
                    bottom: ConstantSize.semiLargePadding),
                child: Text(note.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          height: 1.7,
                          letterSpacing: -0.15,
                        )),
              )
            ],
          ),
        ),
      ),
      CircleIconContainer(
        iconAddress: note.iconAddress,
      ),
    ]);
  }
}
