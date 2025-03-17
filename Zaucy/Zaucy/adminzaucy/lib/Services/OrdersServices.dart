import 'dart:convert';
import 'package:adminzaucy/main.dart';
import 'package:http/http.dart' as http;
import 'package:adminzaucy/Entity/Order.dart';

class Ordersservices {
  Future<List<Order>> getAllOrders() async {
    final response = await http.get(Uri.parse('$baseOriginal/api/orders'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      // Ensure that we're mapping synchronously, and it's not wrapped in a Future.
      List<Order> orders = [];
      for (var order in jsonResponse) {
        orders.add(await Order.fromJson(order)); // Ensure synchronous mapping
      }

      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<void> updateOrderStatus(int orderId, String orderstatus) async {
    print(orderId);
    print(orderstatus);
    final response = await http.put(
        Uri.parse('$baseOriginal/api/orders/$orderId?status=$orderstatus'));

    if (response.statusCode == 200) {
      print("order Status updated Succesfully");
    } else {
      print("Failed to Change Status");
    }
  }

  Future<List<Order>> fetchPendingOrders() async {
    try {
      final response =
          await http.get(Uri.parse("$baseOriginal/api/orders/pending"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body) as List;

        List<Order> orders = [];
        for (var order in jsonResponse) {
          orders.add(await Order.fromJson(order)); // Ensure synchronous mapping
        }

        return orders; // Wait for all futures to complete
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception(
            'Failed to load pending orders: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching orders: $e");
      rethrow;
    }
  }
}
