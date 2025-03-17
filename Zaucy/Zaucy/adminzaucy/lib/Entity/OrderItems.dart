import 'package:adminzaucy/Entity/Order.dart';
import 'package:adminzaucy/menu.dart';

class OrderItem {
  final int? itemId;
  final Order? order;
  final Menu? menu;
  int quantity;
  final double price;

  OrderItem({
    this.itemId,
    this.order,
    required this.menu,
    required this.quantity,
    required this.price,
  });

  double get totalPrice => quantity * price;

  static Future<OrderItem> fromJson(Map<String, dynamic> json) async {
    return OrderItem(
      itemId: json['itemId'] as int?,
      order: json['order'] != null ? await Order.fromJson(json['order']) : null,
      menu: json['menu'] != null ? Menu.fromJson(json['menu']) : null,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  // Method to convert OrderItem to JSON (for sending to the backend)
  Map<String, dynamic> toJson() {
    return {
      'order_id': order?.orderId,
      'menu_id': menu?.id, // Pass menu ID
      'quantity': quantity,
      'price': price,
    };
  }
}
