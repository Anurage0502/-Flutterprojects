import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/LocationTracker.dart';
import 'package:zaucy/Pages/cartpage.dart';
import 'package:zaucy/Services/ordeservices.dart';
import 'package:zaucy/main.dart';

class OrderPlacedPage extends StatefulWidget {
  final Order PlacedOrder; // Update to Menu type, not dynamic

  OrderPlacedPage({required this.PlacedOrder});

  @override
  _OrderPlacedPageState createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  late AudioPlayer _audioPlayer;
  late Order placedorder;

  Timer? _timer;

  void startFetchingOrders() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getOrderDetails(
          placedorder.orderId); // Fetch order status every 5 seconds
    });

    Future.delayed(Duration(seconds: 10), () {
      if (placedorder.status == OrderStatus.pending) {
        setState(() {
          placedorder.status = OrderStatus.Inprogress;
        });
      }
    });
  }

  void stopFetchingOrders() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playOrderplaceSound();
    placedorder = widget.PlacedOrder;
    startFetchingOrders();
    if (placedorder.status == OrderStatus.completed) {
      startFetchingOrders();
    }
  }

  void getOrderDetails(int orderId) async {
    Order? order = await OrderService().fetchOrderById(orderId);

    if (order != null) {
      setState(() {
        placedorder = order;
      });
    } else {
      print("Order not found!");
    }
  }

  void _playOrderplaceSound() async {
    await _audioPlayer.setSource(
        AssetSource("Just eat courier order offer sound effect.mp3"));
    await _audioPlayer.setVolume(1);
    await _audioPlayer
        .play(AssetSource("Just eat courier order offer sound effect.mp3"));
    await _audioPlayer.resume();
  }

  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) => {
        if (didPop)
          {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homepage()))
          }
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Background color
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie animation for the celebration (Choose an animation you like)
              Lottie.asset(
                'assets/Animation - 1738221790666.json',
                height: 200,
              ),

              // The "Woohoo! Order Placed!" text

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedOpacity(
                  opacity: 0.5, // Fade in effect
                  duration: Duration(seconds: 5),
                  child: Text(
                    'Woohoo! Order Placed!',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),

              // Subtext
              AnimatedOpacity(
                opacity: 0.2,
                duration: Duration(seconds: 5),
                child: Text(
                  'Your order will be processed soon.',
                  style: TextStyle(fontSize: 15, color: Colors.brown),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Order Status:${placedorder.status.toString().split('.').last}"),
                ],
              ),

              // Button to return home or go back
              SizedBox(height: 50),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Navigate back to the previous screen (or anywhere else)
                          cartItems = [];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                        },
                        child: Icon(
                          Icons.home_filled,
                          color: Colors.brown,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Mappage(
                                        PlacedOrder: placedorder,
                                      )));
                        },
                        child: Text("Track your Order"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
