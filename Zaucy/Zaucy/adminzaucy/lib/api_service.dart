import 'package:adminzaucy/main.dart';
import 'package:adminzaucy/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseurl = "$baseOriginal/api";
  Future<List<Menu>> fetchallmenu() async {
    final response = await http.get(Uri.parse('$baseurl/menu'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Menu.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch menu items');
    }
  }

  Future<void> updateMenuItem(String? id, Menu menu) async {
    final response = await http.put(
      Uri.parse('$baseurl/menu/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(menu.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update menu item');
    }
  }

  Future<void> deleteMenuItem(String? id) async {
    final response = await http.delete(Uri.parse('$baseurl/menu/$id'));

    if (response.statusCode == 204 || response.statusCode == 200) {
      print('Menu item deleted successfully!');
    } else {
      throw Exception('Failed to delete menu item: ${response.statusCode}');
    }
  }

  Future<void> addMenuItem(Menu menuItem) async {
    try {
      final url = Uri.parse('$baseurl/menu');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(menuItem), // Convert the menu item to JSON
      );

      if (response.statusCode == 201) {
        // Successfully created
        print('Menu item added: ${response.body}');
      } else {
        print('Failed to add menu item. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
