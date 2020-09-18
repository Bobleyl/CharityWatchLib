import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charity_watch/model/charity_model.dart';

Future<List<Charity>> filterCharities(String category) async {
  print("Starting API Call....");
  var url = "urlHere";
  return http
      .post(url, body: "{" + "\"category\": \"$category\" }")
      .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 200) {
      print("Good Response");
      final temp = json.decode(response.body);
      List<Charity> list = [];
      for (var each in temp) {
        Charity temp_charity = Charity.fromJson(each);
        list.add(temp_charity);
      }
      return list;
    } else {
      print("Bad Response");
      return null;
    }
  });
}
