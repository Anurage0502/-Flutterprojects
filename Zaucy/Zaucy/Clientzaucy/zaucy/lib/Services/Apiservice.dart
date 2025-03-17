import 'package:zaucy/main.dart';
import 'package:zaucy/Entities/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Apiservice {
  final String baseurl = "$baseurlOriginal/api";
  Future<List<Menu>> fetchallmenu() async {
    final response = await http.get(Uri.parse('$baseurl/menu'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Menu.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch menu items');
    }
  }

  Future<Menu?> fetchMenuById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseurl/menu/$id'));

      if (response.statusCode == 200) {
        // Parse the JSON data and return the Menu object
        return Menu.fromJson(json.decode(response.body));
      } else {
        // If the server returns an error, throw an exception
        throw Exception('Failed to load menu item');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<Menu>> fetchVegPizzasFromApi() async {
    // Return List<Menu>
    final response = await http.get(Uri.parse('$baseurl/menu/vegpizza'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Menu> menus = List<Menu>.from(
          l.map((json) => Menu.fromJson(json))); // Use Menu.fromJson
      return menus; // Return List<Menu>
    } else {
      throw Exception('Failed to load Veg pizzas: ${response.statusCode}');
    }
  }

  Future<List<Menu>> fetchNonVegPizzasFromApi() async {
    // Return List<Menu>
    final response = await http.get(Uri.parse('$baseurl/menu/nonvegpizza'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Menu> menus = List<Menu>.from(
          l.map((json) => Menu.fromJson(json))); // Use Menu.fromJson
      return menus; // Return List<Menu>
    } else {
      throw Exception('Failed to load Non-Veg pizzas: ${response.statusCode}');
    }
  }
}
