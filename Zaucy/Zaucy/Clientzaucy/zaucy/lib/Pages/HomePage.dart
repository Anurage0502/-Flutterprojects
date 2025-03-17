import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:zaucy/Entities/Coupon.dart';
import 'package:zaucy/Entities/menu.dart';
import 'package:zaucy/Pages/Categorywisepage.dart';
import 'package:zaucy/Pages/HomepageBody.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/Profilepage.dart';
import 'package:zaucy/Pages/SingleLooking.dart';
import 'package:zaucy/Pages/SplashScreen.dart';
import 'package:zaucy/Pages/cartpage.dart';
import 'package:zaucy/Services/Apiservice.dart';
import 'package:zaucy/Services/CouponServices.dart';
import 'package:zaucy/Services/ordeservices.dart';
import 'package:zaucy/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> Categories = ["All", "Veg", "NonVeg"];
  int _currentIndex = 0;

  void initState() {
    super.initState();

    if (globalorder22 == null) {
      createNewOrder();
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    setState(() {});
  }

  final List<Widget> _pages = [Homepagebody(), Cartpage(), Profilepage()];

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromRGBO(255, 250, 205, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black, // Ensures background color is applied
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                  color: Colors.amber,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.shopping_cart_sharp,
                  color: Colors.amber,
                ),
                label: 'Add to Cart'),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.person,
                  color: Colors.amber,
                ),
                label: 'Profile'),
          ],
          fixedColor: Colors.white,
        ),
      ),
    );
  }
}
