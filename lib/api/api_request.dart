import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helper/app_constant.dart';

class ApiRequest {
  static Future get({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      http.Response response = await http
          .get(Uri.parse("${AppConstant.baseUrl}$url"), headers: headers);
      return jsonDecode(response.body);
    } catch (exception) {
      return null;
    }
  }

  static Future post() async {}
}
