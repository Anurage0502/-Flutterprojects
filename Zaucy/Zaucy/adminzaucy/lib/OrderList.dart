import 'package:adminzaucy/Entity/Order.dart';
import 'package:adminzaucy/Services/OrdersServices.dart';
import 'package:adminzaucy/ordersmainpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderlistPage extends StatefulWidget {
  final Order order22;
  final Function(int) onOrderRemoved;
  OrderlistPage({required this.order22, required this.onOrderRemoved});

  @override
  State<OrderlistPage> createState() => _OrderlistPageState();
}

class _OrderlistPageState extends State<OrderlistPage>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late Order orders;
  bool _updateStatus = false;
  late AnimationController _controller;
  Ordersservices ordersservices = Ordersservices();

  @override
  void initState() {
    super.initState();
    orders = widget.order22;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    print("Order Items Length: ${orders.orderItems.length}"); // Debug
  }

  void _handleClick(int Orderid, String orderstatus) {
    if (!_updateStatus) {
      _controller.forward().then((_) {
        ordersservices.updateOrderStatus(Orderid, orderstatus);
        widget.onOrderRemoved(Orderid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
          print("Expanded: $_isExpanded"); // Debug
        });
      },
      child: Card(
        margin: EdgeInsets.all(16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedContainer(
          decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 44, 102, 46), width: 2)),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
          height: _isExpanded ? 330 : 150,
          padding: EdgeInsets.all(16),
          child: Column(
            // Change Row to Column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Order No: ${orders.orderId}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _handleClick(orders.orderId, "completed");
                          _updateStatus = true;
                        });
                      },
                      icon: _updateStatus
                          ? Lottie.asset(
                              "assets/Animation - 1738300426458.json",
                              height: 60,
                              width: 60,
                              repeat: false)
                          : Icon(
                              Icons.check_box_outline_blank_rounded,
                              size: 30,
                            ))
                ],
              ),
              Text("Total Price: ${orders.totalPrice}",
                  style: TextStyle(fontSize: 20)),
              Text("Quantity: ${orders.orderItems.length}",
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              if (_isExpanded)
                Expanded(
                  child: SizedBox(
                    height: 200, // Set a fixed height
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders.orderItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 44, 102, 46),
                                    width: 10),
                                color: Color.fromRGBO(255, 243, 218, 1),
                              ),
                              width: 280,
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Name: ${orders.orderItems[index].menu!.name}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Size: ${orders.orderItems[index].menu!.size}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Quantity:${orders.orderItems[index].quantity}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
