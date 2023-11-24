// ignore_for_file: file_names
import 'dart:convert';
import 'package:pizzaapp/model/autocompletepredection.dart';

class PlaceautoResponse {
  final String? status;
  final List<AutocompletePredection>? prediction;
  PlaceautoResponse({this.prediction, this.status});
  factory PlaceautoResponse.fromJson(Map<String, dynamic> json) {
    return PlaceautoResponse(
        status: json['status'] as String?,
        // ignore: prefer_null_aware_operators
        prediction: json['predections'] != null
            ? json['predections'].map<AutocompletePredection>(
                (json) => AutocompletePredection.fromjson(json))
            : null);
  }
  static PlaceautoResponse placeautoresult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceautoResponse.fromJson(parsed);
  }
}
