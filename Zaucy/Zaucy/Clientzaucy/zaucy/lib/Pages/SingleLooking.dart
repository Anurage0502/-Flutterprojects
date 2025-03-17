import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/menu.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/Singlelookingcard.dart';
import 'package:zaucy/Pages/cartpage.dart';
import 'package:zaucy/Services/orderitemsservices.dart';
import 'package:zaucy/main.dart';

class SingleLooking extends StatefulWidget {
  final Menu menuItem;
  const SingleLooking({super.key, required this.menuItem});

  @override
  State<SingleLooking> createState() => _SingleLookingState();
}

class _SingleLookingState extends State<SingleLooking> {
  late final Menu menuItem;
  final OrderItemsService orderitemservice = OrderItemsService();

  @override
  void initState() {
    super.initState();
    menuItem = widget.menuItem;
  }

  Future<void> addItem(BuildContext context, OrderItem newItem) async {
    try {
      await orderitemservice.createOrderItem(newItem);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item added to cart successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(screenHeight),
            _buildSliverList(screenHeight, screenWidth),
            SliverToBoxAdapter(
                child: ResponsiveCard(
                    screenWidth: screenWidth, screenHeight: screenHeight))
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(screenWidth, context),
      ),
    );
  }

  Widget _buildSliverAppBar(double screenHeight) {
    return SliverAppBar(
      expandedHeight: screenHeight / 3,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border_outlined, color: Colors.red),
          style: IconButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 243, 208),
          ),
        )
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        },
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        style: IconButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 243, 208),
          shape: const CircleBorder(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
        title: _buildFlexibleSpaceTitle(),
        background: Image.network(menuItem.imageUrl, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildFlexibleSpaceTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(menuItem.name,
            style: GoogleFonts.abhayaLibre(
                color: Colors.white, fontWeight: FontWeight.bold)),
        Text(menuItem.description,
            style: GoogleFonts.abhayaLibre(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10)),
      ],
    );
  }

  Widget _buildSliverList(double screenHeight, double screenWidth) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _buildHeader(screenWidth),
        _buildDescription(screenHeight),
      ]),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Container(
      height: 100,
      width: screenWidth,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "${menuItem.name} – A Timeless Classic!",
          style: GoogleFonts.abhayaLibre(
              fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDescription(double screenHeight) {
    return SizedBox(
      height: screenHeight / 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Indulge in the irresistible taste of a classic ${menuItem.name}, where every bite is a perfect balance of savory, cheesy, and crispy goodness.",
          style: GoogleFonts.abhayaLibre(
              fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(double screenWidth, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          if (globalorder22 != null) {
            final OrderItem newItem = OrderItem(
              menu: menuItem,
              order: globalorder22!,
              quantity: 1,
              price: menuItem.price,
            );

            await addItem(context, newItem);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Cartpage()));
          } else {
            print("Global order not initialized yet.");
          }
        },
        child: SizedBox(
          height: 50,
          width: screenWidth,
          child: const Center(child: Text("Add to cart")),
        ),
      ),
    );
  }
}
