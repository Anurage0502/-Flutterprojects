import 'dart:convert';
import 'package:deliverylocation/Models/Deliverylocation.dart';
import 'package:http/http.dart' as http;

class DeliveryBoyService {
  static const String baseUrl = "http://192.168.1.33:8080";

  // 🔹 Update Delivery Boy Location (PUT request)
  static Future<bool> updateLocation(DeliveryBoyLocation location) async {
    final url = Uri.parse("$baseUrl/api/location/update");

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(location.toJson()),
      );

      if (response.statusCode == 200) {
        print("Location updated successfully.");
        return true;
      } else {
        print("Failed to update location: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error updating location: $e");
      return false;
    }
  }

  // 🔹 Get Latest Location (GET request)
  static Future<DeliveryBoyLocation?> getLocation(int deliveryBoyId) async {
    final url = Uri.parse("$baseUrl/api/location/get/$deliveryBoyId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return DeliveryBoyLocation.fromJson(jsonData);
      } else {
        print("Failed to fetch location: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching location: $e");
      return null;
    }
  }

  // 🔹 Create Initial Delivery Boy Location (POST request)
  static Future<int?> createLocation(DeliveryBoyLocation location) async {
    final url = Uri.parse("$baseUrl/api/location/create");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(location.toJson()),
      );

      if (response.statusCode == 200) {
        print("Delivery boy location created.");
        return int.parse(response.body);
      } else {
        print("Failed to create location: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error creating location: $e");
      return null;
    }
  }
}
