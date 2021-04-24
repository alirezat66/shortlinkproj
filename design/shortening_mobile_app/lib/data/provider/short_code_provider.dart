import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/provider/short_code_api.dart';
import 'package:shortening_mobile_app/data/service/short_code_service.dart';

class ShortCodeProvider implements BaseService {
  ShortCodeApi shortenApi;
  ShortCodeProvider.createApi() {
    shortenApi = ShortCodeApi(StringValue.urlCloud);
  }

  @override
  Future<ShortCodeResult> shortLink(String url) async {
    try {
      var response = await shortenApi.getAsync('url=$url');
      ShortCodeResult result = ShortCodeResult.fromJson(response);
      return result;
    } catch (e) {
      throw e;
    }
  }
}
