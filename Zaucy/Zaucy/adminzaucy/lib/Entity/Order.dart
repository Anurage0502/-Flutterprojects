import 'dart:convert';

import 'package:adminzaucy/Entity/OrderItems.dart';

enum OrderStatus { pending, completed, cancelled }

extension OrderStatusExtension on OrderStatus {
  static OrderStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'completed':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        throw Exception('Unknown order status: $status');
    }
  }
}

class Order {
  final int orderId;
  final DateTime createdAt;
  OrderStatus status;
  double totalPrice;
  final List<OrderItem> orderItems; // Now stores full OrderItem objects

  Order({
    required this.orderId,
    required this.createdAt,
    required this.status,
    required this.totalPrice,
    required this.orderItems,
  });

  // Convert Order object to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'createdAt': createdAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'totalPrice': totalPrice,
      'orderItems': orderItems
          .map((item) => item.toJson())
          .toList(), // Convert each OrderItem to JSON
    };
  }

  // Create an Order from JSON
  static Future<Order> fromJson(Map<String, dynamic> json) async {
    var itemList = json['orderItems'] as List?;

    // Convert JSON objects to Future<OrderItem> instances and wait for all
    List<OrderItem> orderItemList = itemList != null
        ? await Future.wait(
            itemList.map((item) async => await OrderItem.fromJson(item)))
        : [];

    return Order(
      orderId: json['orderId'],
      createdAt: DateTime.parse(json['createdAt']),
      status: OrderStatusExtension.fromString(json['status']),
      totalPrice: json['totalPrice'] ?? 0.0,
      orderItems: orderItemList,
    );
  }
}
