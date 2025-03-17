import 'package:adminzaucy/Entity/Order.dart';
import 'package:adminzaucy/OrderList.dart';
import 'package:adminzaucy/Services/OrdersServices.dart';
import 'package:flutter/material.dart';

late Future<List<Order>> orderlist;
List<Order>? DakhavList = [];

class Ordersmainpage extends StatefulWidget {
  const Ordersmainpage({super.key});

  @override
  State<Ordersmainpage> createState() => _OrdersmainpageState();
}

class _OrdersmainpageState extends State<Ordersmainpage> {
  Ordersservices ordersservices = Ordersservices();
  List<Order>? orderListState;
  void initState() {
    super.initState();
    orderlist = ordersservices.fetchPendingOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 102, 46),
        leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
          future: orderlist,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.data);
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              if (orderListState == null) {
                orderListState = snapshot.data; // Store data in state
              }
              void removeOrder(int orderId) {
                setState(() {
                  orderListState!
                      .removeWhere((order) => order.orderId == orderId);
                });
              }

              if (orderListState!.length != 0) {
                return Stack(
                  children: [
                    Center(child: Image.asset("assets/logo.png")),
                    ListView.builder(
                        itemCount: orderListState!.length,
                        itemBuilder: (context, index) {
                          return OrderlistPage(
                            order22: orderListState![index],
                            onOrderRemoved: removeOrder,
                          );
                        })
                  ],
                );
              } else {
                return Center(
                    child: Text(
                  'Zero Pending Orders Found',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ));
              }
            }
          }),
    );
  }
}
