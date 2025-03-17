import 'package:flutter/material.dart'; // Assuming you have this page to view the cart
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/Globalorder.dart';
import 'package:zaucy/Pages/Customization.dart';
import 'package:zaucy/Services/CartServices.dart';
import 'package:zaucy/Services/orderitemsservices.dart';
import 'package:zaucy/Pages/cartpage.dart';
import 'package:zaucy/main.dart'; // Replace with your actual main.dart if needed
import 'package:zaucy/Entities/menu.dart';
// Import the CartService

class MenuItemCard extends StatefulWidget {
  final Menu menuItem; // Update to Menu type, not dynamic

  MenuItemCard({required this.menuItem});

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  CartService _cartService = CartService();
  OrderItemsService orderitemservice = OrderItemsService();
  bool _isExpanded = false;
  late final Menu menuItem22;
  void initState() {
    super.initState();
    menuItem22 = widget.menuItem;
  }

  Future<void> addItem(BuildContext context, OrderItem newItem) async {
    try {
      // You can replace this with an actual API call to add the item on the server
      await orderitemservice.createOrderItem(newItem);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item added to cart successfully')),
      );
    } catch (e) {
      // Handle failure (e.g., network error)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width * 0.9,
        height: _isExpanded ? 230 : 200,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Card(
          margin: EdgeInsets.all(16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 150,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: widget.menuItem,
                        child: Image.network(
                          widget.menuItem.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.menuItem.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('₹${widget.menuItem.price}',
                            style: TextStyle(fontSize: 18)),
                        Text('Size:${widget.menuItem.size}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400)),
                        if (_isExpanded) ...[
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    // Create an OrderItem from the Menu
                                    print(
                                        "---------------------------------------------------------");
                                    print(menuItem22.id);
                                    print(globalorder22!.orderId);
                                    print(alreadyfetchedorderitems);
                                    if (globalorder22 != null) {
                                      OrderItem newItem = OrderItem(
                                        menu: menuItem22,
                                        order: globalorder22!,
                                        quantity: 1, // Default quantity
                                        price: widget.menuItem.price,
                                      );
                                      await addItem(context, newItem);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Cartpage()));
                                    } else {
                                      print(
                                          "Global order not initialized yet.");
                                    }
                                  },
                                  child: Icon(Icons.add_shopping_cart_outlined),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (globalorder22 != null) {
                                      OrderItem newItem = OrderItem(
                                        menu: menuItem22,
                                        order: globalorder22!,
                                        quantity: 1, // Default quantity
                                        price: widget.menuItem.price,
                                      );

                                      await addItem(context, newItem);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Customization(
                                                      orderItem: newItem)));
                                    } else {
                                      print(
                                          "Global order not initialized yet.");
                                    }
                                  },
                                  child: Container(
                                    height: 20,
                                    child: Text('Customize'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
