import 'dart:convert';
import 'dart:io';

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

  postRequestWithFile(String url, Map data, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      request.files.add(
        await http.MultipartFile.fromPath('note_file', file.path),
      );
      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
