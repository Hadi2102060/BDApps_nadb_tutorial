import 'package:e_commerce/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const E_CommerceApp());
}

class E_CommerceApp extends StatelessWidget {
  const E_CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce App",
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: Homescreen(),
    );
  }
}
