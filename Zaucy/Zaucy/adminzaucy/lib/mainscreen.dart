import 'package:adminzaucy/Services/OrdersServices.dart';
import 'package:adminzaucy/manage_pizza.dart';
import 'package:adminzaucy/ordersmainpage.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _tomatoAnimation;
  late Animation<double> _basilAnimation;
  late final AnimationController _controller;

  bool isClicked = false;
  void initState() {
    super.initState();

    // Start the animation just once

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _controller.forward();

    // Define animations for ingredients
    _tomatoAnimation = Tween<double>(begin: 0.0, end: 400).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _basilAnimation = Tween<double>(begin: 0.0, end: 400.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _onPizzaBoxClicked() {
    if (isClicked) {
      _controller.reverse(); // Animate ingredients back
    } else {
      _controller.forward(); // Animate ingredients outward
    }
    isClicked = !isClicked; // Toggle state
  }

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(-5, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));
  late final Animation<Offset> _offsetAnimationbasil = Tween<Offset>(
    begin: Offset(1, -1), // Right Bottom
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: 100 + _tomatoAnimation.value,
                left: MediaQuery.of(context).size.width / 2 -
                    20 +
                    _tomatoAnimation.value,
                child: Image.asset("assets/tomato.png", width: 250),
              );
            },
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: 100 + _basilAnimation.value,
                right: MediaQuery.of(context).size.width / 2 -
                    10 +
                    _basilAnimation.value,
                child: Image.asset("assets/basil.png", width: 250),
              );
            },
          ),
          Positioned(
            bottom: 100 + _basilAnimation.value,
            right: MediaQuery.of(context).size.width / 2 -
                20 +
                _basilAnimation.value,
            child: GestureDetector(
              onTap: _onPizzaBoxClicked,
              child: Image.asset("assets/logo.png", width: 100),
            ),
          ),
          Center(
            child: SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Opacity(
                    opacity: 0.6,
                    child: Image.asset(
                      "assets/logo.png",
                      width: 120,
                      height: 120,
                    )),
              ),
            ),
          ),
          SlideTransition(
            position: _offsetAnimationbasil,
            child: Opacity(
                opacity: 1,
                child: Image.asset(
                  "assets/basil.png",
                  width: 200,
                  height: 200,
                )),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManagePizza()));
                    },
                    child: Container(
                      child: Center(child: Text("MANAGE PIZZA ")),
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 249, 160, 153),
                                Colors.white
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 2, color: Colors.black)),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Ordersmainpage()));
                      // _____________________________________________________________________________________________________________________
                    },
                    child: Container(
                      child: Center(child: Text("INQUIRE ORDERS")),
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 249, 160, 153),
                                Colors.white
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 2, color: Colors.black)),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
