import 'package:flutter/material.dart';
import 'package:shortening_mobile_app/constant/constant_sizes.dart';
import 'package:shortening_mobile_app/data/model/footer_menu.dart';
import 'footer_subtitle_widget.dart';
import 'footer_title_widget.dart';

class FooterList extends StatelessWidget {
  final List<FooterMenu> menu;
  const FooterList({
    Key key,
    @required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                bottom:
                    index != menu.length - 1 ? ConstantSize.largePadding : 0),
            child: ListTile(
              title: FooterTitle(
                text: menu[index].title,
              ),
              subtitle: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: menu[index].subStrings.length,
                  itemBuilder: (context, subIndex) {
                    return FooterSubTitle(
                        text: menu[index].subStrings[subIndex]);
                  }),
            ),
          );
        });
  }
}
