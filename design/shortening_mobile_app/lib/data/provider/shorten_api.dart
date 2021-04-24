import 'dart:convert';

import 'package:http/http.dart' as http;

class ShortenApi {
  String url;

  ShortenApi(this.url);

  Future<dynamic> getAsync(String endPoint) async {
    var url = this._getFinalURL(endPoint);
    print(url);

    final response = await http.get(url, headers: {
      "Content-type": "application/json",
    });
    print(response.body.toString());
    return json.decode(response.body);
  }

  _getFinalURL(String endpoint) {
    var url;
    if (endpoint.startsWith('/')) {
      url = this.url + "/shorten" + endpoint;
    } else {
      return url + "/shorten?" + endpoint;
    }
  }
}
