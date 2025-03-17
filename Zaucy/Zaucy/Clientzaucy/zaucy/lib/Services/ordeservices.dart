import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/main.dart';

class OrderService {
  static Future<Order?> createOrder(int userid) async {
    final url = Uri.parse("$baseurlOriginal/api/orders/$userid");

    // You can either send empty orderItems or create initial OrderItems
    final orderData = {
      "createdAt": DateTime.now().toIso8601String(),
      "status": "pending",
      "totalPrice": 0.0,
      'user': globaluser22,
      "orderItems": [], // Empty orderItems or send actual OrderItems data
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        // Parse the response data directly without nested structures
        return Order.fromJson(responseData);
      } else {
        print("Failed to create order: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error occurred while creating order: $e");
      return null;
    }
  }

  Future<Order?> placeOrder(int orderId, Order updatedOrder) async {
    final url = Uri.parse('$baseurlOriginal/api/orders/place/$orderId');

    // Prepare the request body
    final body = json.encode(updatedOrder);

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Check for successful response
      if (response.statusCode == 200) {
        // If successful, parse the response
        return json.decode(response.body);
      } else {
        // If there's an error, throw an exception with the error message
        throw Exception('Failed to place order: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error placing order: $error');
    }
  }

  Future<List<Order>> getOrdersByUserId(int userId) async {
    final url = Uri.parse('$baseurlOriginal/api/orders/user/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List;

      // Correctly handle the Future<Order> from the map operation
      final orderFutures =
          jsonList.map((json) => Order.fromJson(json)).toList();
      final orders =
          await Future.wait(orderFutures); // Wait for all futures to complete
      return orders;
    } else if (response.statusCode == 204) {
      return []; // Return an empty list if no content (204)
    } else {
      throw Exception(
          'Failed to load orders: ${response.statusCode}'); // Handle errors
    }
  }

  Future<Order?> fetchOrderById(int id) async {
    final String baseUrl = "$baseurlOriginal/api"; // Your API base URL
    final Uri url = Uri.parse("$baseUrl/orders/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Order.fromJson(data); // Convert JSON to Order object
      } else {
        print("Order not found. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching order: $e");
      return null;
    }
  }
}
