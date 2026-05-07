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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Contract'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Connections'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
        selectedItemColor: const Color(0xFF4A2C8F),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

    );
  }
}