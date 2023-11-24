import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkUltily {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? header}) async {
    try {
      final reponse = await http.get(uri, headers: header);
      if (reponse.statusCode == 200) {
        return reponse.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
