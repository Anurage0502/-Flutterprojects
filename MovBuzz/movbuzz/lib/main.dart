import 'package:flutter/material.dart';
import 'package:movbuzz/homescreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'movfluxx',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Colors.black, useMaterial3: true),
      home: homescreen(),
    );
  }
}
