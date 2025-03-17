import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/main.dart';

class OrderItemsService {
  final String baseurl = "$baseurlOriginal/api";

  // Fetch all OrderItems
  Future<List<OrderItem>> fetchOrderItems() async {
    final response = await http.get(Uri.parse('$baseurl/orderitems'));
    final statuscode = response.statusCode;
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Wait for all the OrderItem futures to resolve
      List<OrderItem> orderItems = await Future.wait(data.map((json) =>
              OrderItem.fromJson(
                  json)) // Mapping each json to Future<OrderItem>
          );

      return orderItems;
    } else {
      throw Exception('Failed to fetch order items:$statuscode');
    }
  }

  // Create a new OrderItem
  Future<void> createOrderItem(OrderItem orderItem) async {
    final url = Uri.parse('$baseurl/orderitems');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(orderItem.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode != 201) {
        // Log detailed backend error
        print('Backend Error: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to create order item');
      }
    } catch (error) {
      print('Request Failed: $error');
      rethrow;
    }
  }

//ekach order che sagle orderitem sathi
  Future<List<OrderItem>> getOrderItemsBy22OrderId(int? orderId) async {
    final response = await http.get(Uri.parse('$baseurl/orderitems/$orderId'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response and map to List<OrderItem>
      List<dynamic> data = json.decode(response.body);

      // Map the data to a list of Future<OrderItem> and then wait for all to complete
      List<Future<OrderItem>> futures = data.map((item) async {
        return await OrderItem.fromJson(item); // Ensure it's awaited here
      }).toList();

      // Wait for all Futures to complete and return the resulting list of OrderItem objects
      List<OrderItem> orderItems = await Future.wait(futures);

      return orderItems; // Return the list of OrderItem objects
    } else {
      throw Exception('Failed to load order items');
    }
  }

  Future<void> deleteOrderItem(int? id) async {
    final url = Uri.parse('$baseurl/orderitems/$id');

    try {
      final response = await http.delete(url);

      if (response.statusCode != 204) {
        print(
            'Failed to delete OrderItem: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to delete OrderItem');
      }
    } catch (error) {
      print('Request Failed: $error');
      rethrow;
    }
  }

//Json File Sathi
  Future<OrderItem> getOrderItemsByOrderId(int? orderId) async {
    final response =
        await http.get(Uri.parse('$baseurl/orderitems/single/$orderId'));

    if (response.statusCode == 200) {
      // Parse the JSON response and map it directly to a single OrderItem
      var data = json.decode(response.body);

      // If you expect a single item, just return the OrderItem
      return OrderItem.fromJson(data); // No need to use Future.wait
    } else {
      throw Exception('Failed to load order item in getOrderItemsByOrderId');
    }
  }

  Future<void> updateOrderItem(OrderItem orderItem) async {
    final String apiUrl =
        "http://localhost:59045/api/orderitems/${orderItem.itemId}"; // Adjust as needed
    String? token = await storage.read(key: 'auth_token');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(orderItem.toJson());

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print("✅ OrderItem updated successfully.");
      } else {
        print(
            "❌ Failed to update OrderItem. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (error) {
      print("🚨 Request Failed: $error");
      rethrow;
    }
  }

  Future<void> updateOrderItemQuantity(
      int? orderItemId, int newQuantity) async {
    final String apiUrl =
        "$baseurl/orderitems/$orderItemId?quantity=$newQuantity";
    String? token = await storage.read(key: 'auth_token');
    print(token);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(headers);

    try {
      final response = await http.put(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        print("✅ OrderItem quantity updated successfully.");
      } else {
        print(
            "❌ Failed to update OrderItem. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (error) {
      print("🚨 Request Failed: $error");
      rethrow;
    }
  }

  Future<void> addListToppings(int? orderItemId, int? toppingsId) async {
    final String url =
        '$baseurl/ListTopping?orderitemid=$orderItemId&toppingsid=$toppingsId'; // Adjust URL if needed

    try {
      final response = await http.post(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        print('Toppings added successfully: ${response.body}');
      } else {
        print('Failed to add toppings. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding toppings: $e');
    }
  }

  Future<void> updateOrderItemPrice(int? orderItemId, double? newPrice) async {
    final String apiUrl =
        "$baseurl/orderitems/Price/$orderItemId?Price=$newPrice";
    String? token = await storage.read(key: 'auth_token');
    print(token);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.put(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        print("✅ OrderItem  Price updated successfully.: $newPrice");
      } else {
        print(
            "❌ Failed to update OrderItem. Status: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (error) {
      print("🚨 Request Failed: $error");
      rethrow;
    }
  }
}
