import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {

  const BottomNav({super.key});
  @override
  State<BottomNav> createState() => _BottomNavState();

}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context){


    return BottomNavigationBar(items: _selectedIndex);
  }
}