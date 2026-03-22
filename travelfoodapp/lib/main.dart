import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const TravelFoodApp());
}

class TravelFoodApp extends StatelessWidget {
  const TravelFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Food Recommendation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFFFF9F5),
      ),
      home: const SplashScreen(),
    );
  }
}