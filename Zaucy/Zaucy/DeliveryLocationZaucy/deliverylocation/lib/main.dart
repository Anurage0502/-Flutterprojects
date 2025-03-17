import 'package:deliverylocation/Pages/MainPage.dart';
import 'package:deliverylocation/Pages/MapPage.dart';
import 'package:flutter/material.dart';

String baseurlOriginal = "http://192.168.1.42:8080";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Mainpage());
  }
}
