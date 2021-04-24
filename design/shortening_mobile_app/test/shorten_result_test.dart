import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';

void main() {
  group('test shorten_result', () {
    test('check fromJson method value in Ok State', () {
      String correctResult =
          '{"ok": true,"result": {"code": "8ZXsk","short_link": "shrtco.de/8ZXsk","full_short_link": "https://shrtco.de/8ZXsk","short_link2": "9qr.de/8ZXsk","full_short_link2": "https://9qr.de/8ZXsk","short_link3": "shiny.link/8ZXsk","full_short_link3": "https://shiny.link/8ZXsk","share_link": "shrtco.de/share/8ZXsk","full_share_link": "https://shrtco.de/share/8ZXsk","original_link": "https://remotederm.ca"}}';

      Map<String, dynamic> resultMap = jsonDecode(correctResult);
      ShortenResult result = ShortenResult.fromJson(resultMap);
      expect(result.result['code'], '8ZXsk');
      expect(result.isOk, true);
    });
    test('check fromJson method value in Error State', () {
      String wrongResult =
          '{"ok": false,"error_code": 1,"error": "No url parameter set. Make a GET or POST request with a `url` parameter containing a URL you want to shorten. For more infos see shrtco.de/docs"}';

      Map<String, dynamic> resultMap = jsonDecode(wrongResult);
      ShortenResult result = ShortenResult.fromJson(resultMap);
      expect(result.result, null);
      expect(result.isOk, false);
      expect(result.errorCode, 1);
    });
  });
}
