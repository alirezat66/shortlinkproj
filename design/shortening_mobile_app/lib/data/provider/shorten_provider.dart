import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/provider/shorten_api.dart';
import 'package:shortening_mobile_app/data/service/shorten_service.dart';

class ShortenProvider implements BaseService {
  ShortenApi shortenApi;
  ShortenProvider.createApi() {
    shortenApi = ShortenApi(StringValue.urlCloud);
  }

  @override
  Future<ShortenResult> shortLink(String url) async {
    try {
      var response = await shortenApi.getAsync('url=$url');
      ShortenResult result = ShortenResult.fromJson(response);
      return result;
    } catch (e) {
      throw e;
    }
  }
}
