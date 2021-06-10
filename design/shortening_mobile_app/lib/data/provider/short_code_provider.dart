import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/provider/short_code_api.dart';
import 'package:shortening_mobile_app/data/service/short_code_service.dart';

class ShortCodeProvider implements BaseService {
  static ShortCodeProvider _instance;
  static ShortCodeProvider getInstance() {
    if (_instance == null) {
      _instance = ShortCodeProvider();
    }
    if (_shortenApi == null) {
      _shortenApi = ShortCodeApi(StringValue.urlCloud);
    }
    return _instance;
  }

  static ShortCodeApi _shortenApi;

  @override
  Future<ShortCodeLink> shortLink(String url) async {
    try {
      var response = await _shortenApi.getAsync('url=$url');
      ShortCodeLink linkResult =
          ShortCodeLink.fromJson(response['result'] as Map<String, dynamic>);
      //ShortCodeResult result = ShortCodeResult.fromJson(response);
      return linkResult;
    } catch (e) {
      throw e;
    }
  }
}
