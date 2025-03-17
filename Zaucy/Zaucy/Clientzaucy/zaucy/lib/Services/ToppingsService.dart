import 'dart:convert';

import 'package:zaucy/Entities/toppings.dart';
import 'package:http/http.dart' as http;
import 'package:zaucy/main.dart';

class Toppingsservice {
  static String baseUrl = "$baseurlOriginal/api/Toppings";
  final String baseurl = "$baseurlOriginal/api";

  Future<List<Topping>> fetchToppings() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Topping.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load toppings:${response.statusCode}");
    }
  }

  Future<List<Topping>> fetchToppingforitem(int? orderItemId) async {
    String baseUrl2 = "$baseurlOriginal/api/ListTopping/$orderItemId";
    final response = await http.get(Uri.parse(baseUrl2));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Topping.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load toppings:${response.statusCode}");
    }
  }

  Future<String> deleteListToppings(int? orderItemId, int? toppingsId) async {
    final String url =
        '$baseurl/ListTopping?orderitemid=$orderItemId&toppingsid=$toppingsId'; // Replace with your actual endpoint URL

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'orderitemid': orderItemId,
        'toppingsid': toppingsId,
      }),
    );

    if (response.statusCode == 200) {
      return 'ListToppings removed successfully';
    } else if (response.statusCode == 400) {
      return 'Bad request';
    } else {
      return 'Error: ${response.statusCode}';
    }
  }
}
