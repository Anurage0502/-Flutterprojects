import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/menu.dart'; // Import your Menu entity
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/SingleLooking.dart';
import 'package:zaucy/Pages/cartpage.dart';
import 'package:zaucy/Services/Apiservice.dart';
import 'package:zaucy/Services/orderitemsservices.dart';
import 'package:zaucy/main.dart'; // Import your ApiService

class Categorywisepage extends StatefulWidget {
  late String Category;
  Categorywisepage({required this.Category});

  @override
  State<Categorywisepage> createState() => _CategorywisepageState();
}

class _CategorywisepageState extends State<Categorywisepage> {
  late String Category;
  late Future<List<Menu>> FutureMenu;
  OrderItemsService orderitemservice = OrderItemsService();

  Future<void> addItem(BuildContext context, OrderItem newItem) async {
    try {
      // You can replace this with an actual API call to add the item on the server
      await orderitemservice.createOrderItem(newItem);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item added to cart successfully')),
      );
    } catch (e) {
      // Handle failure (e.g., network error)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add item: $e')),
      );
    }
  } // Changed from Futuremenu to FutureMenu, and type to List<Menu>

  @override
  void initState() {
    super.initState();
    Category = widget.Category;
    if (Category == "Veg") {
      FutureMenu =
          Apiservice().fetchVegPizzasFromApi(); // Call your Apiservice method
    } else if (Category == "All") {
      FutureMenu = Apiservice().fetchallmenu();
    } else {
      FutureMenu = Apiservice()
          .fetchNonVegPizzasFromApi(); // Call your Apiservice method
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => {
        if (didPop) {Navigator.pop(context)}
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF8EEDD), Color(0xFFDABEA7)],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildHeroSection(context, Category),
                  Expanded(
                    child: FutureBuilder<List<Menu>>(
                      // FutureBuilder for List<Menu>
                      future: FutureMenu, // Use FutureMenu
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'Error loading menus: ${snapshot.error}')); // Changed error text to menus
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return _buildEmptyState();
                        } else {
                          return _buildMenuGrid(snapshot
                              .data!); // Changed to _buildMenuGrid and passing snapshot.data!
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, String categoryName) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.network(
          'https://media.istockphoto.com/id/603873020/photo/wood-fired-pizza-with-flames.jpg?s=612x612&w=0&k=20&c=oOgTpMde20tN6NaVFAGgWAeD-MjxLUhFkgYQr01PLAg=',
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ("${categoryName} Pizza"),
                style: GoogleFonts.abhayaLibre(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black54,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
              Text(
                'Freshly Baked, Just For You!',
                style: GoogleFonts.abhayaLibre(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
            top: 0,
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )))
      ],
    );
  }

  Widget _buildMenuGrid(List<Menu> menus) {
    // Changed from _buildPizzaGrid and type to List<Menu>
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.2,
        ),
        itemCount: menus.length, // Use menus.length
        itemBuilder: (context, index) {
          return _buildMenuCard(menus[
              index]); // Changed to _buildMenuCard and passing menus[index]
        },
      ),
    );
  }

  Widget _buildMenuCard(Menu menu) {
    // Changed from _buildPizzaCard and type to Menu
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  menu.imageUrl, // Use menu.imageUrl
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                menu.name, // Use menu.name
                style: GoogleFonts.abhayaLibre(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                menu.description, // Use menu.description
                style: GoogleFonts.abhayaLibre(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\Rs ${menu.price.toStringAsFixed(2)}',
                      style: GoogleFonts.abhayaLibre(
                          fontWeight: FontWeight.bold)), // Use menu.price
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SingleLooking(menuItem: menu)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  // Removed rating stars as they are not in your Menu entity
                  const SizedBox(width: 8),
                  if (menu.isVeg ==
                      true) // Assuming you want to badge Veg items, adjust condition based on your badge criteria
                    _buildBadge(
                        'Veg', Colors.green), // Example badge for Veg items
                  if (menu.isVeg != true) // Example badge for Non-Veg items
                    _buildBadge('Non-Veg',
                        Colors.redAccent), // Example badge for Non-Veg items
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          style: GoogleFonts.abhayaLibre(
              color: color, fontWeight: FontWeight.bold, fontSize: 10)),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No menus available in this category yet. Stay tuned!', // Changed text to menus
            textAlign: TextAlign.center,
            style: GoogleFonts.abhayaLibre(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement "Notify Me" logic
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            ),
            child: const Text('Notify Me'),
          ),
        ],
      ),
    );
  }
}
