import 'dart:convert';

import 'package:http/http.dart' as http;

class ShortCodeApi {
  String url;
  ShortCodeApi(this.url);

  Future<dynamic> getAsync(String endPoint) async {
    var url = this._getFinalURL(endPoint);
    final response = await http.get(Uri.parse(url), headers: {
      "Content-type": "application/json",
    });
    return json.decode(response.body);
  }

  _getFinalURL(String endpoint) {
    if (endpoint.startsWith('/')) {
      return this.url + "/shorten" + endpoint;
    } else {
      return this.url + '/shorten?' + endpoint;
    }
  }
}
