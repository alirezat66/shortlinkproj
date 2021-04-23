import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_colors.dart';
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
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              SizedBox(height: ConstantSize.circleIconContainerSize),
              Text(
                note.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, right: 16, left: 16, bottom: 32),
                child: Text(note.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: ConstantColors.grayishViolet,
                        fontSize: 14,
                        height: 1.5)),
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
