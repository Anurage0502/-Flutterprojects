import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zaucy/Entities/User.dart';
import 'package:zaucy/main.dart';

class Userservices {
  String baseUrl = "$baseurlOriginal/auth/signup";
  Future<User?> signup(String username, String password, String email) async {
    final url = Uri.parse('$baseUrl'); // Corrected URL path
    // Use Form data for @RequestParam
    final request = http.MultipartRequest('POST', url);
    request.fields['username'] = username;
    request.fields['password'] = password;
    request.fields['email'] = email;

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Successful signup, decode the User object from the response
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final user = User.fromJson(userData); // Assuming you have a User model
        return user;
      } else {
        // Handle errors
        print('Signup failed: ${response.statusCode} - ${response.body}');
        // Return null or throw an exception
        return null; // Or throw an exception
      }
    } catch (e) {
      print('Error during signup: $e');
      return null; // Or throw an exception
    }
  }

  Future<String> Login(String username, String otpCode) async {
    final url = Uri.parse('$baseurlOriginal/auth/login'); // Corrected URL path
    // Use Form data for @RequestParam
    final request = http.MultipartRequest('POST', url);
    request.fields['username'] = username;
    request.fields['otpCode'] = otpCode;
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Handle errors
        print('Signup failed: ${response.statusCode} - ${response.body}');
        // Return null or throw an exception
        return "Login Failed Try Again"; // Or throw an exception
      }
    } catch (e) {
      print('Error during signup: $e');
      return "Wrong Credentials"; // Or throw an exception
    }
  }

  Future<bool> validateToken(String token, String username) async {
    final String apiUrl =
        '$baseurlOriginal/auth/validate-token'; // Replace with your actual backend URL
    final String bearerToken = 'Bearer $token';
    print(token); // Construct the Bearer token string

    try {
      final response = await http.get(
        Uri.parse(
            '$apiUrl?username=$username'), // Include username as a query parameter
        headers: {
          'Authorization': bearerToken,
        },
      );

      if (response.statusCode == 200) {
        // Token is valid
        // You can optionally decode the response body if it contains JSON
        // Example:  final Map<String, dynamic> responseData = json.decode(response.body);
        return true; // Or return responseData if you decoded the JSON
      } else if (response.statusCode == 401) {
        // Token is invalid or expired
        print('Token validation failed: ${response.body}');
        return false; // Or throw an exception if you prefer
      } else {
        // Other error
        print(
            'Token validation request failed with status: ${response.statusCode}');
        print(
            'Response body: ${response.body}'); // Print the error for debugging
        return false; // Or throw an exception
      }
    } catch (e) {
      print('Error validating token: $e');
      return false; // Or throw an exception
    }
  }

  Future<User?> getUser(String token) async {
    final String apiUrl =
        '$baseurlOriginal/auth/get-user'; // Update your API URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        return User.fromJson(userData); // Return User object
      } else {
        print("Error: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<String?> getOtp(String username) async {
    try {
      final response = await http.get(
        Uri.parse('$baseurlOriginal/auth/otp?username=$username'),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching OTP: $e');
      return null;
    }
  }
}
