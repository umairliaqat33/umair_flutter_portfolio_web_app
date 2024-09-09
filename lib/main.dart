import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/views/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive App',
      home: SplashScreen(),
    );
  }
}
