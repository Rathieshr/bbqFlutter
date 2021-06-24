import 'dart:convert';

import 'package:bbqisland/menu.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl = "http://192.168.1.5:5000/api/";
  // final String baseUrl = "https://bbq-island.herokuapp.com/api/";

  Future<bool> getLogin(String username, String password) async {
    try {
      var params = {"username": username, "password": password};
      Uri uri = Uri.parse(baseUrl + "user/login");
      var response = await http.post(uri, body: json.encode(params));

      print('---- status code: ${response.statusCode}');
      if (response.statusCode == 200)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<dynamic>> getCategories() async {
    Uri uri = Uri.parse(baseUrl + "menus/categories");
    var response = await http.get(uri);
    print(response.body.toString());
    return jsonDecode(response.body);
  }

  Future<List<Menu>> getMenus() async {
    Uri uri = Uri.parse(baseUrl + "menus");
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data as List).map((p) => Menu.fromJson(p)).toList();
    }
  }
}
