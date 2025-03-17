import 'package:flutter/material.dart';
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/OlderOrders.dart';
import 'package:zaucy/Services/ordeservices.dart';
import 'package:zaucy/main.dart';
import 'package:intl/intl.dart';

class Previousorder extends StatefulWidget {
  const Previousorder({super.key});

  @override
  State<Previousorder> createState() => _PreviousorderState();
}

class _PreviousorderState extends State<Previousorder> {
  late Future<List<Order>> _ordersFuture;
  final OrderService orderService = OrderService();
  @override
  void initState() {
    super.initState();
    _ordersFuture = orderService.getOrdersByUserId(globaluser22!.userId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 45, 103, 37),
        title: Text(
          'Previous Orders',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Homepage()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Show error message
          } else if (snapshot.hasData) {
            final orders = snapshot.data!;
            if (orders.isEmpty) {
              return const Center(child: Text("No Orders Found"));
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OlderOrder(order22: order)));
                    },
                    child: Card(
                      margin: EdgeInsets.all(16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 5,
                                color: const Color.fromARGB(255, 45, 103, 37)),
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(
                            'Order ID: ${order.orderId}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                          ),
                          trailing: Text(
                            'Created At: ${DateFormat('dd/MM/yyyy').format(order.createdAt)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ));
              },
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
