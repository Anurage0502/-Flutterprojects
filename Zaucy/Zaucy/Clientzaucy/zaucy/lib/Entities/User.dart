import 'package:zaucy/Entities/Order.dart';

class User {
  final int userId;
  final String username;
  final String
      password; // In a real app, you would NOT store the plain password!
  String? email;
  final String? phoneNumber;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? updatedAt; // updatedAt can be null initially
  final List<Otp>? otps; // Otps are a list, and can be null
  final List<Order>? orders; // Orders are a list, and can be null

  User({
    required this.userId,
    required this.username,
    required this.password,
    this.email,
    this.phoneNumber,
    required this.isVerified,
    required this.createdAt,
    this.updatedAt,
    this.otps,
    this.orders,
  });

  static Future<User> fromJson(Map<String, dynamic> json) async {
    var itemList = json['order'] as List?;

    // Convert JSON objects to Future<OrderItem> instances and wait for all
    List<Order> orderItemList2 = itemList != null
        ? await Future.wait(
            itemList.map((item) async => await Order.fromJson(item)))
        : [];
    return User(
        userId: json['userId'],
        username: json['username'],
        password: json['password'], // DO NOT STORE PLAIN PASSWORDS!
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        isVerified: json['is_verified'] == 1, // Convert tinyint/int to bool
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null, // Handle nullable updatedAt
        // Parse Otp list
        orders: orderItemList2 // Parse Order list
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password, // In a real app, hash the password before sending!
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, password: $password, email: $email, phoneNumber: $phoneNumber, isVerified: $isVerified, createdAt: $createdAt, updatedAt: $updatedAt, otps: $otps, orders: $orders}';
  }
}

class Otp {
  // Define Otp model
  // ... Otp properties (e.g., otpId, code, expiryTime, etc.)
  // Important: Adapt this to your actual Otp structure
  final int otpId; // Example
  // ... other properties

  Otp({
    required this.otpId,
  }); // Example

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
      otpId: json['otp_id'], // Example
      // ... other properties
    );
  }
}
