import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_urls.dart';

class ApiHandler {
  Future<dynamic> get({
    required final String url,
    final Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('${ApiUrls.baseUrl}$url');
    final response = await http.get(uri);
    final responseJson = _response(response);
    return responseJson;
  }

  dynamic _response(final http.Response? response) {
    if ((response?.statusCode == 200 || response?.statusCode == 201) &&
        response?.body != null) {
      return json.decode(response!.body);
    } else {
      throw Exception('API call failed.');
    }
  }
}
