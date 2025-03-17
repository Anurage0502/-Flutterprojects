import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/User.dart';
import 'package:zaucy/Pages/Addingusername.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/Loginpage.dart';
import 'package:zaucy/Services/UserServices.dart';
import 'package:zaucy/main.dart';

class SplashScreen22 extends StatefulWidget {
  @override
  _SplashScreen22State createState() => _SplashScreen22State();
}

class _SplashScreen22State extends State<SplashScreen22> {
  @override
  void initState() {
    super.initState();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3));
    String? token = await storage.read(key: 'auth_token');
    String? username = await storage.read(key: 'username');

    if (token != null && username != null) {
      bool isValid = await Userservices().validateToken(token, username);

      if (isValid) {
        User? user = await Userservices().getUser(token);
        globaluser22 = user;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
        return;
      }
    }

    // If token is invalid or missing, navigate to login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Addingusername()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lottie animation for splash screen
            Lottie.asset(
              'assets/Animation - 1738229889574.json',
              width: 450,
              height: 450,
              repeat: false,
            ),
            SizedBox(height: 20),
            // Splash Screen Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Zaucy Pizza!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
