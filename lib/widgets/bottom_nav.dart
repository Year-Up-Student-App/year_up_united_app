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

    return BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: 'Contract'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Attendance'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Connections'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'More'),
        ]
    );
  }
}