import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';

import 'link_item_widget.dart';

class ShortLinkListView extends StatelessWidget {
  final Function(int) onClick;
  const ShortLinkListView({
    Key key,
    @required ShortCodeLinkList shortCodeList,
    this.onClick,
  })  : _shortCodeList = shortCodeList,
        super(key: key);

  final ShortCodeLinkList _shortCodeList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _shortCodeList.links.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return LinkItem(
          item: _shortCodeList.links[index],
          onPressed: () {
            onClick(
              index,
            );
          },
        );
      },
    );
  }
}
