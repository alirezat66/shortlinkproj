import 'package:flutter_test/flutter_test.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/provider/short_code_provider.dart';

void main() {
  ShortCodeProvider shp;

  group('test shorten api link', () {
    test('check api for true result', () async {
      shp = ShortCodeProvider.createApi();
      ShortCodeResult result = await shp.shortLink('https://remotederm.ca');
      expect(result.isOk, true);
      ShortCodeLink link = ShortCodeLink.fromJson(result.result);
      expect(link.code.runtimeType, String);
    });
    test('check api for false result', () async {
      shp = ShortCodeProvider.createApi();
      ShortCodeResult result = await shp.shortLink('');
      expect(result.isOk, false);
    });
  });
}
