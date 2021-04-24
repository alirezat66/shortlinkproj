import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';

void main() {
  group('test shorten_link', () {
    test('check fromJson method value', () {
      Map<String, dynamic> resultMap = jsonDecode(
          '{"code": "KCveN","short_link": "shrtco.de/KCveN","full_short_link": "https://shrtco.de/KCveN","short_link2": "9qr.de/KCveN","full_short_link2": "https://9qr.de/KCveN","share_link": "shrtco.de/share/KCveN","full_share_link": "https://shrtco.de/share/KCveN","original_link": "http://example.org/very/long/link.html"}');
      ShortCodeLink link = ShortCodeLink.fromJson(resultMap);
      expect(link.code, 'KCveN');
    });
    test('check empty json', () {
      Map<String, dynamic> resultMap = jsonDecode('{}');
      ShortCodeLink link = ShortCodeLink.fromJson(resultMap);
      expect(link.code, null);
    });
    test('check setAsCopiedByIndex method ', () {
      Map<String, dynamic> resultMap = jsonDecode(
          '{"code": "KCveN","short_link": "shrtco.de/KCveN","full_short_link": "https://shrtco.de/KCveN","short_link2": "9qr.de/KCveN","full_short_link2": "https://9qr.de/KCveN","share_link": "shrtco.de/share/KCveN","full_share_link": "https://shrtco.de/share/KCveN","original_link": "http://example.org/very/long/link.html"}');
      ShortCodeLink link = ShortCodeLink.fromJson(resultMap);
      ShortCodeLink link2 = ShortCodeLink.fromJson(resultMap);
      ShortCodeLink link3 = ShortCodeLink.fromJson(resultMap);
      ShortCodeLinkList list = ShortCodeLinkList();
      list.links.add(link);
      list.links.add(link2);
      list.links.add(link3);

      expect(list.links[1].isCopied, false);
      list.setAsCopiedByIndex(1);
      expect(list.links[1].isCopied, true);
      expect(list.links[0].isCopied, false);
      list.setAsCopiedByIndex(0);
      expect(list.links[1].isCopied, false);
      expect(list.links[0].isCopied, true);
    });
  });
}
