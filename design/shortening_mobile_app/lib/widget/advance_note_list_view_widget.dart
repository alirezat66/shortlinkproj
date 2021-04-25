import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';
import 'package:shortening_mobile_app/data/model/advance_note.dart';

import 'advance_item_widget.dart';

class AdvanceNoteListView extends StatelessWidget {
  const AdvanceNoteListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AdvanceNote> list = AdvanceNoteList().list;

    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index != list.length - 1) {
            return Column(
              children: [
                AdvanceItem(note: list[index]),
                Container(
                  width: ConstantSize.semiSmallPadding,
                  height: ConstantSize.extraLargePadding,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            );
          } else {
            return AdvanceItem(note: list[index]);
          }
        });
  }
}
