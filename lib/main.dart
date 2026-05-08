import 'package:flutter/material.dart';
import 'package:flutter_app/screens/attendance_screen.dart';
import 'package:flutter_app/screens/connections_screen.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/contract_screen.dart';
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
      home: const MainLayout(), // this is the first screen that loads
    );
  }
}

class MainLayout extends StatefulWidget{
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>{

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ContractScreen(),
    const AttendanceScreen(),
    const ConnectionsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNav(
        onTabSelected: (index) {
          setState(() {
            _selectedIndex = index;
      });  },),
    );
  }

}