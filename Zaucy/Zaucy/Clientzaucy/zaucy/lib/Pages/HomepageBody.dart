import 'package:carousel_slider_x/carousel_slider_x.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/Coupon.dart';
import 'package:zaucy/Entities/menu.dart';
import 'package:zaucy/Pages/Categorywisepage.dart';
import 'package:zaucy/Pages/SingleLooking.dart';
import 'package:zaucy/Services/Apiservice.dart';
import 'package:zaucy/Services/CouponServices.dart';

class Homepagebody extends StatefulWidget {
  const Homepagebody({super.key});

  @override
  State<Homepagebody> createState() => _HomepagebodyState();
}

class _HomepagebodyState extends State<Homepagebody> {
  late Future<List<Menu>> Futuremenu;
  late Future<List<Coupon>> FutureCoupons;
  late Future<List<Menu>> FutureMenuveg;
  List<dynamic> CouponPosters = [
    Image.asset("assets/Coupon Posters/SAVE10.png",
        filterQuality: FilterQuality.high, fit: BoxFit.cover),
    Image.asset("assets/Coupon Posters/Flat50.png",
        filterQuality: FilterQuality.high, fit: BoxFit.fill),
    Center(
      child: Column(
        children: [
          Lottie.asset("assets/Coupon Posters/Holi.json",
              filterQuality: FilterQuality.high, fit: BoxFit.fill),
          Text(
            "Happy Holi From Zaucy\nEnjoy your Holiday with a Pizza",
            style: GoogleFonts.abhayaLibre(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          )
        ],
      ),
    )
  ];

  void initState() {
    super.initState();
    Futuremenu = Apiservice().fetchallmenu();
    FutureCoupons = Couponservices().getallActiveCoupons();
    FutureMenuveg = Apiservice().fetchVegPizzasFromApi();
  }

  @override
  Widget build(BuildContext context) {
    List<String> Categories = ["All", "Veg", "NonVeg"];
    int _currentIndex = 0;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Zaucy Pizza",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Welcome to Heaven of Pizza",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Offers and Events",
              style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
                future: FutureCoupons,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Lottie.asset(
                            "assets/Animation - 1738222611391.json"));
                  } else if (snapshot.hasError) {
                    print(snapshot.data);
                    print(snapshot.error);
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final CouponItems = snapshot.data!;
                    return CarouselSlider.builder(
                        itemCount: 3,
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          viewportFraction: 1,
                          autoPlayCurve: Curves.easeInBack,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          enlargeCenterPage: true,
                          pageSnapping: true,
                        ),
                        itemBuilder: (context, itemIndex, PageViewIndex) {
                          return Container(
                              height: screenHeight / 4,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CouponPosters[itemIndex],
                                ),
                              ));
                        });
                  }
                }),
            Text(
              "Categories",
              style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  itemCount: Categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categorywisepage(
                                      Category: Categories[index],
                                    )));
                      },
                      child: Card(
                        color: Color.fromRGBO(255, 250, 205, 1),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black, width: 0.2), // Border here
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                        margin: EdgeInsets.all(4),
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Categories[index],
                                  softWrap: false,
                                  style: GoogleFonts.abhayaLibre(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Popular Products",
                  style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Categorywisepage(Category: "All")));
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.abhayaLibre(color: Colors.amber),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: screenHeight / 4.5,
              child: FutureBuilder(
                  future: Futuremenu,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Lottie.asset(
                              "assets/Animation - 1738222611391.json"));
                    } else if (snapshot.hasError) {
                      print(snapshot.data);
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final menuitems = snapshot.data!;
                      print(menuitems);
                      return ListView.builder(
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleLooking(
                                            menuItem: menuitems[index])));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                ),
                                margin: EdgeInsets.all(8),
                                width: screenWidth / 1.8,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/logo.png", // Add a static placeholder
                                        image: menuitems[index].imageUrl,
                                        width: screenWidth / 1.8,
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.high,
                                        fadeInDuration: Duration(
                                            milliseconds:
                                                300), // Smooth fade-in
                                        fadeOutDuration: Duration(
                                            milliseconds:
                                                100), // Avoid flickering on exit
                                        imageErrorBuilder: (context, error,
                                                stackTrace) =>
                                            Icon(Icons
                                                .error), // Handle errors gracefully
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              height: screenWidth / 16,
                                              width: screenHeight / 16,
                                              child: Center(
                                                  child: Text(
                                                "+",
                                                style: GoogleFonts.abhayaLibre(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // ignore: unnecessary_string_interpolations
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${menuitems[index].name}",
                                          style: GoogleFonts.abhayaLibre(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${menuitems[index].description}",
                                          style: GoogleFonts.abhayaLibre(
                                              color: Colors.white, fontSize: 5),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Veg Products",
                  style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Categorywisepage(Category: "Veg")));
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.abhayaLibre(color: Colors.amber),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: screenHeight / 4.5,
              child: FutureBuilder(
                  future: FutureMenuveg,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Lottie.asset(
                              "assets/Animation - 1738222611391.json"));
                    } else if (snapshot.hasError) {
                      print(snapshot.data);
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final menuitems = snapshot.data!;
                      print(menuitems);
                      return ListView.builder(
                          itemCount: menuitems.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleLooking(
                                            menuItem: menuitems[index])));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                ),
                                margin: EdgeInsets.all(8),
                                width: screenWidth / 1.8,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/logo.png", // Add a static placeholder
                                        image: menuitems[index].imageUrl,
                                        width: screenWidth / 1.8,
                                        fit: BoxFit.fill,
                                        filterQuality: FilterQuality.high,
                                        fadeInDuration: Duration(
                                            milliseconds:
                                                300), // Smooth fade-in
                                        fadeOutDuration: Duration(
                                            milliseconds:
                                                100), // Avoid flickering on exit
                                        imageErrorBuilder: (context, error,
                                                stackTrace) =>
                                            Icon(Icons
                                                .error), // Handle errors gracefully
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              height: screenWidth / 16,
                                              width: screenHeight / 16,
                                              child: Center(
                                                  child: Text(
                                                "+",
                                                style: GoogleFonts.abhayaLibre(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    // ignore: unnecessary_string_interpolations
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${menuitems[index].name}",
                                          style: GoogleFonts.abhayaLibre(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${menuitems[index].description}",
                                          style: GoogleFonts.abhayaLibre(
                                              color: Colors.white, fontSize: 5),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
