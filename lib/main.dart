import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

// MyApp is the root of your entire application
// Think of it like your Main class in Java
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YU United',
      debugShowCheckedModeBanner: false, // removes the red "DEBUG" banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A2C8F), // your purple color
        ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display', // matches your mockup font
      ),
      home: const HomeScreen(), // this is the first screen that loads
    );
  }
}

class MainLayout extends StatefulWidget{
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>{

  final List<Widget> _screens = [

  ];

  @override

}