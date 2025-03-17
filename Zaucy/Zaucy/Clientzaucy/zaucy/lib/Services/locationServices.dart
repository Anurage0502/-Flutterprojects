import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zaucy/Entities/DeliveryLocation.dart';
import 'package:zaucy/main.dart';

class DeliveryBoyService {
  static String baseUrl = baseurlOriginal;

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

  Future<double?> getDistance(
      double startLat, double startLng, double endLat, double endLng) async {
    const apiKey = '5b3ce3597851110001cf62484e1b9a78d58a4555a2d1e8a656e26006';
    const url = 'https://api.openrouteservice.org/v2/directions/driving-car';

    final response = await http.post(
      Uri.parse('$url?api_key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'coordinates': [
          [startLng, startLat],
          [endLng, endLat]
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final distanceMeters = data['routes'][0]['summary']['distance'];
      return distanceMeters / 1000; // Convert to km
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }

  Future<double?> getDuration(
      double startLat, double startLng, double endLat, double endLng) async {
    const apiKey = '5b3ce3597851110001cf62484e1b9a78d58a4555a2d1e8a656e26006';
    const url = 'https://api.openrouteservice.org/v2/directions/driving-car';

    final response = await http.post(
      Uri.parse('$url?api_key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'coordinates': [
          [startLng, startLat],
          [endLng, endLat]
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final duration22 = data['routes'][0]['summary']['duration'];
      return duration22 / 60; // Convert to km
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }
}
