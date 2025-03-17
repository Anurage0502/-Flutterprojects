import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zaucy/Entities/Coupon.dart';
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/Entities/Order_items.dart';
import 'package:zaucy/Entities/User.dart';
import 'package:zaucy/Pages/Addingusername.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Entities/menu.dart';
import 'package:zaucy/Pages/Loginpage.dart';
import 'package:zaucy/Pages/LocationTracker.dart';
import 'package:zaucy/Pages/Otpgeneration.dart';
import 'package:zaucy/Pages/Signuppage.dart';
import 'package:zaucy/Pages/SingleLooking.dart';
import 'package:zaucy/Pages/SplashScreen.dart';
import 'package:zaucy/Services/UserServices.dart';

List<Menu> globalmenuitems = [];
Order? globalorder22;
User? globaluser22;
final storage = FlutterSecureStorage();
String? authtoken;
String? username22;
bool alreadyfetchedorderitems = false;
String baseurlOriginal = "http://192.168.1.37:8080";
bool addedcouponglobal = false;
late List<Coupon>? Allcoupons;
int Couponindex = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  authtoken = await storage.read(key: "auth_token");
  username22 = await storage.read(key: "username");

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen22());
  }
}
