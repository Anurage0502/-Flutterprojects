import 'package:adminzaucy/mainscreen.dart';
import 'package:adminzaucy/menu.dart';
import 'package:flutter/material.dart';

List<Menu> MenuList = [];
String baseOriginal = "http://192.168.1.46:8080";
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Mainscreen());
  }
}
