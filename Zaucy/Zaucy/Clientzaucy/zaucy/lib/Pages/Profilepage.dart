import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zaucy/Pages/LocationTracker.dart';
import 'package:zaucy/Pages/PreviousOrder.dart';
import 'package:zaucy/Pages/SplashScreen.dart';
import 'package:zaucy/main.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.sizeOf(context).height;
    double screenwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDABEA7),
        automaticallyImplyLeading: false,
        toolbarHeight: screenwidth / 3,
        centerTitle: true,
        title: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Card(
                  elevation: 30,
                  shadowColor: Colors.brown,
                  shape: CircleBorder(),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 0.8,
                            color: Color.fromARGB(255, 126, 109, 97))),
                    height: screenheight / 8,
                    child: Image.asset(
                      "assets/logo.png",
                      scale: 2,
                    ),
                  ),
                ),
                Text(
                  "Welcome to zaucy ${globaluser22!.username}",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Text(
                    "Track your Order",
                    style: GoogleFonts.anuphan(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        if (globalorder22!.isPlaced == true) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Mappage(
                                        PlacedOrder: globalorder22!,
                                      )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No order Placed yet')),
                          );
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.locationPin,
                        color: const Color.fromARGB(255, 17, 86, 142),
                      )),
                ],
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: Container(
                height: 1,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Text(
                    "Previous Order",
                    style: GoogleFonts.anuphan(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Previousorder()));
                      },
                      icon: Icon(
                        FontAwesomeIcons.history,
                        color: const Color.fromARGB(255, 17, 86, 142),
                      )),
                ],
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: Container(
                height: 1,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Text(
                    "LOGOUT",
                    style: GoogleFonts.anuphan(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        await storage.delete(key: 'username');
                        await storage.delete(key: 'auth_token');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen22()));
                      },
                      icon: Icon(
                        Icons.logout,
                        color: const Color.fromARGB(255, 17, 86, 142),
                      )),
                ],
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: Container(
                height: 1,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
