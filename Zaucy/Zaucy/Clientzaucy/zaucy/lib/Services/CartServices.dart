import 'package:zaucy/Entities/Order_items.dart';

class CartService {
  List<OrderItem> _cartItems = [];

  // Get all cart items
  List<OrderItem> getCartItems() {
    return _cartItems;
  }

  // Add an item to the cart
  void addToCart(OrderItem item) {
    _cartItems.add(item);
  }

  // Remove an item from the cart
  void removeFromCart(int itemId) {
    _cartItems.removeWhere((item) => item.itemId == itemId);
  }

  // Clear the cart
  void clearCart() {
    _cartItems.clear();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void increaseQuantity(int? itemId) {
    final itemIndex = _cartItems.indexWhere((item) => item.itemId == itemId);
    if (itemIndex != -1) {
      _cartItems[itemIndex].quantity++;
    }
  }

  void updateQuantity(int? itemId, int quantity) {
    final itemIndex = _cartItems.indexWhere((item) => item.itemId == itemId);
    if (itemIndex != -1) {
      _cartItems[itemIndex].quantity = quantity;
    }
  }

  void decreaseQuantity(int? itemId) {
    final itemIndex = _cartItems.indexWhere((item) => item.itemId == itemId);
    if (itemIndex != -1 && _cartItems[itemIndex].quantity > 1) {
      _cartItems[itemIndex].quantity--;
    }
  }
}
