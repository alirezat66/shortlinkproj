import 'package:flutter_test/flutter_test.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/provider/shorten_provider.dart';

void main() {
  ShortenProvider shp;

  group('test shorten api link', () {
    test('check api for true result', () async {
      shp = ShortenProvider.createApi();
      ShortenResult result = await shp.shortLink('https://remotederm.ca');
      expect(result.isOk, true);
    });
    test('check api for false result', () async {
      shp = ShortenProvider.createApi();
      ShortenResult result = await shp.shortLink('');
      expect(result.isOk, false);
    });
  });
}
