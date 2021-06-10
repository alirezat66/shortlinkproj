import 'package:connectivity/connectivity.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/short_code_link.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/provider/short_code_provider.dart';

abstract class BaseService {
  Future<ShortCodeLink> shortLink(String url);
}

class ShortCodeService implements BaseService {
  BaseService _service = ShortCodeProvider.getInstance();

  @override
  Future<ShortCodeLink> shortLink(String url) async {
    if (await _checkConnection()) {
      return _service.shortLink(url);
    } else {
      throw Exception('We have no internet');
    }
  }

  Future<bool> _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
