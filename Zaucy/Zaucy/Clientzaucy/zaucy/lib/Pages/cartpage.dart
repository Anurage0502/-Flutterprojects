import 'dart:collection';
import 'dart:ffi';
import 'dart:math';

import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/Coupon.dart';
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/toppings.dart';
import 'package:zaucy/Pages/Customization.dart';
import 'package:zaucy/Pages/ErrorPage.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/Orderplaced.dart';
import 'package:zaucy/Services/CartServices.dart';
import 'package:zaucy/Services/CouponServices.dart';
import 'package:zaucy/Services/ToppingsService.dart';
import 'package:zaucy/Services/orderitemsservices.dart';
import 'package:zaucy/Services/Apiservice.dart';
import 'package:zaucy/Services/ordeservices.dart';
import 'package:zaucy/main.dart';

late Future<List<OrderItem>> futureorderitemlist;
late List<OrderItem> cartItems;
Map<int, bool> Customization23 = LinkedHashMap();

class Cartpage extends StatefulWidget {
  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage>
    with SingleTickerProviderStateMixin {
  final CartService cartService = CartService();
  OrderItemsService orderitemservice = OrderItemsService();
  Apiservice apiservice = Apiservice();
  OrderService orderService = OrderService();
  Couponservices couponservices = Couponservices();
  String category = "VEG";
  late Future<List<Coupon>> couponlistCategory;
  late Future<List<Coupon>> couponlistall;
  List<SlidableController> _slidableControllers = [];
  bool addedcoupon = addedcouponglobal;
  late AnimationController _animationController;
  late Animation<double> _animation;

  double totalpriceorder = 0;

  Color getGlossyColor() {
    final random = Random();
    double hue = random.nextDouble() * 360; // Random hue (0-360)
    return HSLColor.fromAHSL(1.0, hue, 1.0, 0.6).toColor();
  }

  List<Color> generateRandomColors(int count) {
    return List.generate(count, (index) => getGlossyColor());
  }

  void initState() {
    super.initState();
    futureorderitemlist = fetchOrderItems();
  }

  void iscustomized(int? orderItemId, int index) async {
    List<Topping> toppingsfororderitem =
        await Toppingsservice().fetchToppingforitem(orderItemId);
    if (toppingsfororderitem.isEmpty) {
      if (orderItemId != null) {
        Customization23[orderItemId] = false;
      } else {
        // Handle the case where orderItemId is null (e.g., log an error, provide a default value)
        print("orderItemId is null, cannot set Customization23.");
      }
    } else {
      if (orderItemId != null) {
        Customization23[orderItemId] = true;
        print("$toppingsfororderitem--------------------------------");
      } else {
        // Handle the case where orderItemId is null (e.g., log an error, provide a default value)
        print("orderItemId is null, cannot set Customization23.");
      }
    }
  }

  Future<List<Coupon>> fetchAllCoupons() async {
    List<Coupon> AllCoupons =
        await couponservices.getValidCoupons("ALL", getTotalPrice().toDouble());
    return AllCoupons;
  }

  Future<void> updatePrice(
      BuildContext context, double priceChange, OrderItem orderItem) async {
    try {
      orderItem.price += priceChange; // Update price
      await OrderItemsService()
          .updateOrderItemPrice(orderItem.itemId, orderItem.price);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update price: $e')),
      );
    }
  }

  Future<List<Coupon>> fetchAllcategoryCoupons() async {
    List<Coupon> AllCoupons = await couponservices.getValidCoupons(
        category, getTotalPrice().toDouble());
    return AllCoupons;
  }

  Future<List<OrderItem>> fetchOrderItems() async {
    List<OrderItem> orderItems =
        await orderitemservice.getOrderItemsBy22OrderId(globalorder22!.orderId);
    print("------============================------");
    print(orderItems[orderItems.length - 1].itemId);
    cartItems = orderItems;
    categoryDEFINE(cartItems);
    couponlistall =
        couponservices.getValidCoupons("ALL", getTotalPrice().toDouble());
    couponlistCategory =
        couponservices.getValidCoupons(category, getTotalPrice().toDouble());
    setState(() {}); // Check if itemId exists
    return orderItems;
  }

  void categoryDEFINE(List<OrderItem> orderitems) {
    bool isveg = true;
    for (var i = 0; i < orderitems.length; i++) {
      if (orderitems[i].menu!.isVeg != true) {
        isveg = false;
      }
    }
    if (isveg == false) {
      category = "NON_VEG";
    }
  }

  Future<void> removeItem(BuildContext context, int? id) async {
    try {
      await orderitemservice.deleteOrderItem(id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item removed successfully')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }

  Future<void> updateItem(
      BuildContext context, int? orderItemId, int newQuantity) async {
    try {
      await orderitemservice.updateOrderItemQuantity(orderItemId, newQuantity);
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

  double getTotalPriceflatdiscount(double value) {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total - value;
  }

  double getTotalPricepercentageDiscount(double value) {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total - total * value / 100;
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

  void showCouponAppliedAnimation(BuildContext context) {
    // Define the OverlayEntry variable
    late OverlayEntry overlayEntry;

    // Initialize the OverlayEntry
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Semi-transparent background
          Positioned.fill(
            child: GestureDetector(
              onTap: () => overlayEntry.remove(), // Remove overlay on tap
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Centered Lottie animation
          Center(
            child: Lottie.asset(
              'assets/Animation - 1740050654294.json',
              width: 300,
              height: 300,
              repeat: false,
              onLoaded: (composition) {
                // Remove the overlay after the animation completes
                Future.delayed(composition.duration, () {
                  overlayEntry.remove();
                });
              },
            ),
          ),
          // "Yay! Coupon Applied" text
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 200), // Adjust as needed
              child: Text('Yay! Coupon Applied!',
                  style: GoogleFonts.pacifico(
                    fontSize: 30,
                    color: Colors.orange,
                  )),
            ),
          ),
        ],
      ),
    );

    // Insert the OverlayEntry into the Overlay
    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return FutureBuilder<List<OrderItem>>(
        future: futureorderitemlist, // Pass the Future here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset(
                    "assets/Animation - 1738222611391.json")); // Show loading indicator
          } else if (snapshot.hasError) {
            return Errorpage(konta: 2);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Homepage();
          } else {
            cartItems = snapshot.data!;
            categoryDEFINE(cartItems);

            return PopScope(
              canPop: true,
              onPopInvokedWithResult: (didPop, Object? result) {
                if (didPop) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                }
              },
              child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Color.fromRGBO(255, 243, 218, 1),
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                        },
                        icon: Icon(Icons.home))),
                backgroundColor: Color.fromRGBO(255, 243, 218, 1),
                extendBodyBehindAppBar: true,
                body: Column(
                  children: [
                    Container(
                      height: screenHeight / 2.5,
                      child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            iscustomized(cartItems[index].itemId, index);

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Customization(
                                            orderItem: cartItems[index])));
                              },
                              child: Slidable(
                                key: ValueKey(cartItems[index].itemId),
                                endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          print(cartItems[index].itemId);
                                          await removeItem(
                                              context, cartItems[index].itemId);
                                          setState(() {
                                            cartItems.removeAt(index);
                                          });
                                        },
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white),
                                    child: SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: screenHeight * 0.1465,
                                            width: screenWidth * 0.251,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  screenWidth * 0.0377),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: Hero(
                                                    tag: cartItems[index],
                                                    child: Image.network(
                                                      cartItems[index]
                                                          .menu!
                                                          .imageUrl,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: screenWidth * 0.0377),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    print(screenWidth);
                                                    print(screenHeight);
                                                  },
                                                  child: Text(
                                                      cartItems[index]
                                                          .menu!
                                                          .name,
                                                      style: GoogleFonts
                                                          .abhayaLibre(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize:
                                                                  screenWidth *
                                                                      0.0500)),
                                                ),
                                                Text(cartItems[index]
                                                    .price
                                                    .toString()),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.remove),
                                                      onPressed: () async {
                                                        if (cartItems[index]
                                                                .quantity >
                                                            1) {
                                                          cartService.updateQuantity(
                                                              cartItems[index]
                                                                  .itemId,
                                                              cartItems[index]
                                                                      .quantity -
                                                                  1);
                                                          print(cartItems[index]
                                                              .itemId);

                                                          setState(() {
                                                            cartItems[index]
                                                                    .quantity =
                                                                cartItems[index]
                                                                        .quantity -
                                                                    1;
                                                          });
                                                          setState(() {});
                                                        }
                                                        await updateItem(
                                                            context,
                                                            cartItems[index]
                                                                .itemId,
                                                            cartItems[index]
                                                                .quantity);
                                                      },
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        cartItems[index]
                                                            .quantity
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .abhayaLibre(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.0502),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.add),
                                                      onPressed: () async {
                                                        cartService.updateQuantity(
                                                            cartItems[index]
                                                                .itemId,
                                                            cartItems[index]
                                                                    .quantity +
                                                                1);
                                                        setState(() {
                                                          cartService
                                                              .increaseQuantity(
                                                                  cartItems[
                                                                          index]
                                                                      .itemId);
                                                          cartItems[index]
                                                              .quantity += 1;

                                                          // Update the local state
                                                        });
                                                        await updateItem(
                                                            context,
                                                            cartItems[index]
                                                                .itemId,
                                                            cartItems[index]
                                                                .quantity);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                (Customization23[
                                                            cartItems[index]
                                                                .itemId] ??
                                                        false)
                                                    ? Row(
                                                        children: [
                                                          Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: screenWidth *
                                                                0.0377,
                                                          ),
                                                          Text(
                                                            "Customized",
                                                            style: GoogleFonts
                                                                .abhayaLibre(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ],
                                                      )
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Default",
                                                            style: GoogleFonts
                                                                .abhayaLibre(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .amber),
                                                          ),
                                                          Text(
                                                            "(Click Anywhere  to Open Customization)",
                                                            style: GoogleFonts
                                                                .abhayaLibre(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .amber),
                                                          ),
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ),
                                          Center(
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
                                                    style:
                                                        GoogleFonts.abhayaLibre(
                                                            fontSize:
                                                                screenWidth *
                                                                    0.0502,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      height: screenHeight / 3,
                      width: screenWidth - 20,
                      child: FutureBuilder(
                          future: couponlistCategory,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Lottie.asset(
                                      "assets/Animation - 1738222611391.json")); // Show loading indicator
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Error: Bhai itha aahe adklay ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return ListviewPizza();
                            } else {
                              Allcoupons = snapshot.data;
                              List<Color> listofColors =
                                  generateRandomColors(Allcoupons!.length);
                              return CarouselSlider.builder(
                                  itemCount: Allcoupons!.length,
                                  options: CarouselOptions(
                                      height: screenWidth * 0.5013,
                                      autoPlay: true,
                                      viewportFraction: 1,
                                      autoPlayInterval: Duration(seconds: 5),
                                      autoPlayCurve: Curves.easeIn,
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 1),
                                      enlargeCenterPage: true,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                      enlargeFactor: 1),
                                  itemBuilder:
                                      (context, itemIndex, PageViewIndex) {
                                    return SizedBox(
                                      width: screenWidth,
                                      child: Card(
                                        color: listofColors[itemIndex],
                                        shadowColor: const Color.fromARGB(
                                            255, 25, 56, 26),
                                        child: Container(
                                            height: screenWidth / 4.8,
                                            width: screenWidth,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth * 0.0251),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(FontAwesomeIcons
                                                              .award),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.0251,
                                                          ),
                                                          Text(
                                                            "${Allcoupons![itemIndex].code}",
                                                            style: GoogleFonts.bungee(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                wordSpacing: 2,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.0502),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.0878,
                                                          ),
                                                          Text(
                                                            Allcoupons![itemIndex]
                                                                        .discountType ==
                                                                    DiscountType
                                                                        .FLAT
                                                                ? "Rs:${Allcoupons![itemIndex].discountValue} Flat OFF on ${getTotalPrice()}"
                                                                : "${Allcoupons![itemIndex].discountValue}% Discount on ${getTotalPrice()}",
                                                            style: GoogleFonts.bungee(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                wordSpacing: 2,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.0251),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth / 28,
                                                  ),
                                                  Container(
                                                    width: 1,
                                                    height: screenHeight /
                                                        screenWidth *
                                                        0.0502,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.0251,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (addedcoupon ==
                                                          false) {
                                                        setState(() {
                                                          Couponindex =
                                                              itemIndex;
                                                          addedcoupon = true;
                                                          showCouponAppliedAnimation(
                                                              context);
                                                          addedcouponglobal =
                                                              true;
                                                        });
                                                      } else {
                                                        if (itemIndex ==
                                                            Couponindex) {
                                                          setState(() {
                                                            addedcoupon = false;
                                                            addedcouponglobal =
                                                                false;
                                                          });
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    "Coupon already applied. Please remove the existing coupon before applying a new one."),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            2)),
                                                          );
                                                        }
                                                      }
                                                    },
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Card(
                                                        elevation: 18,
                                                        child: Container(
                                                          height: 40,
                                                          width: screenWidth *
                                                                  0.2485 -
                                                              20,
                                                          decoration: BoxDecoration(
                                                              color: addedcoupon
                                                                  ? Couponindex == itemIndex
                                                                      ? const Color.fromARGB(255, 255, 199, 32)
                                                                      : Colors.white
                                                                  : Colors.white,
                                                              borderRadius: BorderRadius.circular(screenWidth * 0.0251)),
                                                          child: Center(
                                                            child: Text(
                                                              addedcoupon ==
                                                                          true &&
                                                                      Couponindex ==
                                                                          itemIndex
                                                                  ? "Remove "
                                                                  : "Apply ",
                                                              style: GoogleFonts.abhayaLibre(
                                                                  color: addedcoupon
                                                                      ? Couponindex == itemIndex
                                                                          ? Colors.white
                                                                          : Colors.black
                                                                      : Colors.black,
                                                                  fontSize: 8,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  });
                            }
                          }),
                    )
                  ],
                ),
                floatingActionButton: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          globalorder22!.orderItems = cartItems;
                        });
                        globalorder22!.isPlaced = true;
                        Order neworder = Order(
                            orderId: globalorder22!.orderId,
                            createdAt: globalorder22!.createdAt,
                            status: globalorder22!.status,
                            totalPrice: addedcoupon
                                ? Allcoupons![Couponindex].discountType ==
                                        DiscountType.FLAT
                                    ? getTotalPriceflatdiscount(
                                        Allcoupons![Couponindex].discountValue)
                                    : getTotalPricepercentageDiscount(
                                        Allcoupons![Couponindex].discountValue)
                                : getTotalPrice(),
                            orderItems: globalorder22!.orderItems,
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
                      },
                      child: Container(
                        height: screenWidth * 0.3765,
                        width: screenWidth * 1.0032,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.0251),
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
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: screenWidth * 0.0502,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    addedcoupon
                                        ? Allcoupons![Couponindex]
                                                    .discountType ==
                                                DiscountType.FLAT
                                            ? getTotalPriceflatdiscount(
                                                    Allcoupons![Couponindex]
                                                        .discountValue)
                                                .toString()
                                            : getTotalPricepercentageDiscount(
                                                    Allcoupons![Couponindex]
                                                        .discountValue)
                                                .toString()
                                        : getTotalPrice().toString(),
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: screenWidth * 0.0502,
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
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: screenWidth * 0.0502,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    cartItems.length.toString(),
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: screenWidth * 0.0502,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            Container(
                              height: screenWidth * 0.1080,
                              width: screenWidth * 1.0032,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft:
                                          Radius.circular(screenWidth * 0.0251),
                                      bottomRight: Radius.circular(
                                          screenWidth * 0.0251))),
                              child: Center(
                                  child: Text(
                                "Placeorder",
                                style: GoogleFonts.abhayaLibre(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.0502),
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
