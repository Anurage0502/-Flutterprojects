import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/toppings.dart';
import 'package:zaucy/Pages/Customizationeach.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/cartpage.dart';
import 'package:zaucy/Services/ToppingsService.dart';

class Customization extends StatefulWidget {
  late final OrderItem orderItem;
  Customization({required this.orderItem});

  @override
  State<Customization> createState() => _CustomizationState();
}

class _CustomizationState extends State<Customization> {
  late final OrderItem orderItem;
  late final Future<List<Topping>> FutureListToppings;
  late List<Topping>? toppingsList = List.empty();
  double totalToppingPrice = 0;

  @override
  void initState() {
    super.initState();
    orderItem = widget.orderItem;
    FutureListToppings = fetchallToppings();
    totalToppingPrice = 0; // Reset toppings price every time page is loaded
  }

  Future<List<Topping>> fetchallToppings() async {
    return await Toppingsservice().fetchToppings();
  }

  void updateCalculatedValue(double value) {
    setState(() {
      totalToppingPrice = value; // Store toppings price separately
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) => {
        if (didPop)
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Cartpage()),
            ),
          }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: screenHeight / 2,
              pinned: true,
              floating: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  orderItem.menu!.name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: orderItem,
                  child: Image.network(
                    orderItem.menu!.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Toppings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    height: 450,
                    child: FutureBuilder(
                      future: FutureListToppings,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Lottie.asset(
                                "assets/Animation - 1738222611391.json"),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: Bhai itha aahe adklay ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return ListviewPizza();
                        } else {
                          toppingsList = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: toppingsList!.length,
                            itemBuilder: (context, index) {
                              final toppingitem = toppingsList![index];
                              return Customizationeach(
                                topping: toppingitem,
                                orderItem: orderItem,
                                onCalculationComplete: updateCalculatedValue,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            setState(() {
              orderItem.price += totalToppingPrice;
              if (orderItem.itemId != null && totalToppingPrice > 0) {
                Customization23[orderItem.itemId!] = true;
              } else {
                print("hello");
              }
              // Update price only once
            });
            setState(() {});

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Cartpage()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 10, top: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: Colors.red,
              ),
              width: screenWidth,
              height: 50,
              child: Center(
                child: Text(
                  "Add Customization: Total Price(${orderItem.price + totalToppingPrice})",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
