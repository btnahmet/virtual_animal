import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/home_page.dart';
import 'package:virtual_animal/screens/login.dart';
// Register sınıfını dahil ettik

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo', 
      theme: ThemeData(),
      home:  Login(), // Home yerine doğrudan Login sınıfı kullanılıyor 
    );
  }
}
