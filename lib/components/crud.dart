import 'dart:convert';

import 'package:http/http.dart' as http;

mixin class Crud {
  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
