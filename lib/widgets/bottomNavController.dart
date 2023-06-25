import 'package:flutter/material.dart';
import 'package:manga_reader/constants/constants.dart';
import 'package:manga_reader/screens/home/FavoriteScreen.dart';
import 'package:manga_reader/screens/home/HomeScreen.dart';

import '../constants/AppColors.dart';
import '../screens/home/AuthorScreen.dart';
import '../screens/home/home.dart';

class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    HomeScreen(),
    FavoriteScreen(),
    Author(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Constants.darkgray,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline), 
            label: "Favourite"),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}