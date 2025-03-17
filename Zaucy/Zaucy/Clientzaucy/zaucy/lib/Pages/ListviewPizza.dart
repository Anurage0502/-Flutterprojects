import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Pages/Drawer.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Services/Apiservice.dart';
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/Entities/Globalorder.dart';
import 'package:zaucy/Pages/MenuItemCard.dart';
import 'package:zaucy/Services/ordeservices.dart';
import 'package:zaucy/Entities/globalmenu.dart';
import 'package:zaucy/Entities/menu.dart';
import 'package:zaucy/main.dart';

late Future<List<Menu>> Futuremenu;

class ListviewPizza extends StatefulWidget {
  const ListviewPizza({super.key});

  @override
  State<ListviewPizza> createState() => _ListviewPizzaState();
}

class _ListviewPizzaState extends State<ListviewPizza> {
  bool _isExpanded = false;

  void initState() {
    super.initState();
    Futuremenu = Apiservice().fetchallmenu();
    if (globalorder22 == null) {
      createNewOrder();
    }

    print(globalOrder);
  }

  Future<void> createNewOrder() async {
    globalorder22 = await OrderService.createOrder(globaluser22!.userId);
    if (globalorder22 != null) {
      print("New order created: ${globalorder22!.orderId}");
      print(globalorder22);
    } else {
      print("Failed to create a new order.");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 243, 218, 1),
        centerTitle: true,
        title: Text(
          'Zaucy Pizza!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Futuremenu,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset("assets/Animation - 1738222611391.json"));
            } else if (snapshot.hasError) {
              print(snapshot.data);
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final menuitems = snapshot.data!;
              print(menuitems);
              return Stack(
                children: [
                  Center(child: Image.asset("assets/logo.png")),
                  ListView.builder(
                      itemCount: menuitems.length,
                      itemBuilder: (context, index) {
                        final menuItem = menuitems[index];
                        globalmenu = menuItem;

                        return MenuItemCard(menuItem: menuItem);
                      })
                ],
              );
            }
          }),
    );
  }
}
