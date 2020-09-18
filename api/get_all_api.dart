import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charity_watch/model/charity_model.dart';

Future<List<Charity>> getAllCharities() async {
  var url = "urlHere";
  return http.get(url).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 200) {
      final temp = json.decode(response.body);
      List<Charity> list = [];
      for (var each in temp) {
        Charity temp_charity = Charity.fromJson(each);
        list.add(temp_charity);
      }
      return list;
    } else {
      return null;
    }
  });
}
