import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/Globalorder.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/Orderplaced.dart';
import 'package:zaucy/Services/CartServices.dart';
import 'package:zaucy/Services/orderitemsservices.dart';
import 'package:zaucy/Services/Apiservice.dart';
import 'package:zaucy/Entities/globalmenu.dart';
import 'package:zaucy/Services/ordeservices.dart';
import 'package:zaucy/main.dart';
import 'package:zaucy/Entities/menu.dart';

late Future<List<OrderItem>> futureorderitemlist;

class OlderOrder extends StatefulWidget {
  Order order22;
  OlderOrder({required this.order22});
  @override
  State<OlderOrder> createState() => _OlderOrderState();
}

class _OlderOrderState extends State<OlderOrder> {
  final CartService cartService = CartService();
  OrderItemsService orderitemservice = OrderItemsService();
  Apiservice apiservice = Apiservice();
  OrderService orderService = OrderService();
  List<OrderItem> cartItems = [];
  late Order order22;

  double totalpriceorder = 0;
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureorderitemlist = fetchOrderItems();
  }

  void initState() {
    super.initState();
    order22 = widget.order22;
  }

  Future<List<OrderItem>> fetchOrderItems() async {
    // Example: Fetch data from a service
    return await orderitemservice.getOrderItemsBy22OrderId(order22.orderId);
  }

  Future<void> removeItem(BuildContext context, int? id) async {
    try {
      await orderitemservice.deleteOrderItem(id);
      setState(() {
        cartItems
            .removeWhere((item) => item.itemId == id); // Update the local list
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item removed successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  Future<void> placeOrder(
      BuildContext context, int orderId, Order updatedOrder) async {
    try {
      // Call your API service to place the order
      await orderService.placeOrder(orderId, updatedOrder);

      setState(() {});

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderItem>>(
        future: futureorderitemlist, // Pass the Future here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset(
                    "assets/Animation - 1738222611391.json")); // Show loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: Bhai itha aahe adklay ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return ListviewPizza();
          } else {
            cartItems = snapshot.data!;
            return PopScope(
              canPop: true,
              onPopInvokedWithResult: (didPop, result) => {
                if (didPop)
                  {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homepage()))
                  }
              },
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Color.fromRGBO(255, 243, 218, 1),
                    leading: IconButton(
                        onPressed: () {
                          // Navigate back to the previous page
                          Navigator.pop(context);
                          alreadyfetchedorderitems = true;
                        },
                        icon: Icon(Icons.arrow_back))),
                backgroundColor: Color.fromRGBO(255, 243, 218, 1),
                body: Stack(
                  children: [
                    Center(child: Image.asset("assets/logo.png")),
                    ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            key: ValueKey(cartItems[index].itemId),
                            endActionPane:
                                ActionPane(motion: ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  await removeItem(
                                      context, cartItems[index].itemId);
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: SingleChildScrollView(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: Image.network(
                                                  cartItems[index]
                                                      .menu!
                                                      .imageUrl)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(cartItems[index].menu!.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 15)),
                                            Text(cartItems[index]
                                                .price
                                                .toString()),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: () {
                                                    if (cartItems[index]
                                                            .quantity >
                                                        1) {
                                                      cartService.updateQuantity(
                                                          cartItems[index]
                                                              .itemId,
                                                          cartItems[index]
                                                                  .quantity -
                                                              1);
                                                      setState(() {
                                                        cartItems[index]
                                                            .quantity -= 1;

                                                        // Update the local state
                                                      });
                                                    }
                                                  },
                                                ),
                                                Container(
                                                  child: Text(
                                                    cartItems[index]
                                                        .quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    cartService.updateQuantity(
                                                        cartItems[index].itemId,
                                                        cartItems[index]
                                                                .quantity +
                                                            1);
                                                    setState(() {
                                                      cartItems[index]
                                                              .quantity +=
                                                          1; // Update the local state
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                color: Colors.amberAccent,
                                                child: Text(
                                                  cartItems[index]
                                                      .totalPrice
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
                floatingActionButton: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 30),
                    child: GestureDetector(
                      onTap: () async {
                        Order neworder = Order(
                            orderId: globalorder22!.orderId,
                            createdAt: globalorder22!.createdAt,
                            status: globalorder22!.status,
                            totalPrice: getTotalPrice(),
                            orderItems: cartItems,
                            user: globaluser22,
                            isPlaced: true);

                        await placeOrder(
                            context, globalorder22!.orderId, neworder);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPlacedPage(
                                      PlacedOrder: neworder,
                                    )));
                        globalorder22 = null;
                      },
                      child: Container(
                        height: 150,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Price: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    getTotalPrice().toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Quantity: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    cartItems.length.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 43,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Center(
                                  child: Text(
                                "Use this Order to Place new order",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
