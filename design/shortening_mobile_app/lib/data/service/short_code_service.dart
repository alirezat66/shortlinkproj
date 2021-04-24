import 'package:connectivity/connectivity.dart';
import 'package:shortening_mobile_app/constant/constant_strings.dart';
import 'package:shortening_mobile_app/data/model/shorten_result.dart';
import 'package:shortening_mobile_app/data/provider/short_code_provider.dart';

abstract class BaseService {
  Future<ShortCodeResult> shortLink(String url);
}

class ShortCodeService implements BaseService {
  BaseService service = ShortCodeProvider.createApi();

  @override
  Future<ShortCodeResult> shortLink(String url) async {
    if (await _checkConnection()) {
      return service.shortLink(url);
    } else {
      return ShortCodeResult(isOk: false, error: StringValue.internetError);
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
