import 'package:flutter/material.dart';
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/toppings.dart';
import 'package:zaucy/Services/ToppingsService.dart';
import 'package:zaucy/Services/orderitemsservices.dart';

class Customizationeach extends StatefulWidget {
  final Topping topping;
  final OrderItem orderItem;
  final Function(double) onCalculationComplete;

  Customizationeach({
    required this.topping,
    required this.orderItem,
    required this.onCalculationComplete,
  });

  @override
  State<Customizationeach> createState() => _CustomizationeachState();
}

class _CustomizationeachState extends State<Customizationeach> {
  late Topping topping;
  late OrderItem orderItem;
  late Function(double) onCalculationComplete;

  bool _isclicked = false;

  @override
  void initState() {
    super.initState();
    topping = widget.topping;
    orderItem = widget.orderItem;
    onCalculationComplete = widget.onCalculationComplete;
    checkIfToppingSelected();
  }

  void performCalculation(double price) {
    onCalculationComplete(price); // Now only sends the topping price
  }

  Future<void> updatePrice(BuildContext context, double priceChange) async {
    try {
      orderItem.price += priceChange; // Update price
      await OrderItemsService()
          .updateOrderItemPrice(orderItem.itemId, orderItem.price);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update price: $e')),
      );
    }
  }

  Future<void> checkIfToppingSelected() async {
    try {
      List<Topping> toppings =
          await Toppingsservice().fetchToppingforitem(orderItem.itemId);
      _isclicked = toppings.any((t) => t.id == topping.id);
      setState(() {});
    } catch (e) {
      print('Error fetching toppings: $e');
    }
  }

  void handleToppingClick() {
    setState(() {
      if (!_isclicked) {
        // Add topping
        OrderItemsService().addListToppings(orderItem.itemId, topping.id);
        _isclicked = true;
        updatePrice(context, topping.price);
        performCalculation(topping.price - topping.price);
      } else {
        // Remove topping
        Toppingsservice().deleteListToppings(orderItem.itemId, topping.id);
        _isclicked = false;
        updatePrice(context, -topping.price);
        performCalculation(-topping.price + topping.price);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 10,
      child: Container(
        height: 50,
        child: Row(
          children: [
            IconButton(
              onPressed: handleToppingClick,
              icon: _isclicked
                  ? Icon(Icons.check_box, color: Colors.green)
                  : Icon(Icons.check_box_outline_blank),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("${topping.name}"),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text("₹ ${topping.price}"),
            ),
          ],
        ),
      ),
    );
  }
}
