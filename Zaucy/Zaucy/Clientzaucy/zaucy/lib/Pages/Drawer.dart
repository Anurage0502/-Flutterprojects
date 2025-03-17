import 'package:flutter/material.dart';
import 'package:zaucy/Pages/PreviousOrder.dart';
import 'package:zaucy/Pages/SplashScreen.dart';
import 'package:zaucy/Pages/cartpage.dart';
import 'package:zaucy/main.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 200,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 243, 218, 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 70,
                    height: 70,
                  ),
                  Text(
                    'Zaucy Pizza!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout), // Add an icon
            title: Text('Logout'),
            onTap: () async {
              await storage.delete(key: 'username');
              await storage.delete(key: 'auth_token');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SplashScreen22()));
              print("Logout tapped"); // Example: print to console
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart), // Add an icon
            title: Text('Previous Orders'),
            onTap: () {
              // Handle previous orders navigation here
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Previousorder()));
              print("Previous Orders tapped"); // Example: print to console
            },
          ),
          // Add more drawer items as needed
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Open Cart'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cartpage()));
              print("Settings tapped");
            },
          ),
        ],
      ),
    );
  }
}
