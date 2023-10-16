import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import  "package:test/model/res_model.dart";
import 'package:http/http.dart' as http;

class Api {
  final apiUrl = dotenv.env["DEV_API_URL"];

  static Future<ResObj> get(String url) async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final dynamic jsonMap = json.decode(res.body);

        return ResObj(status: true, code: res.statusCode, data: jsonMap);
      } else {
        return ResObj(status: false, code: res.statusCode, error: res.body);
      }
    } catch (e) {
      return ResObj(status: false, error: "unknown");
    }
  }
}
