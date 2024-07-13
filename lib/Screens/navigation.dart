import 'package:flutter/material.dart';
import 'package:myntra/Screens/home.dart';
import 'package:myntra/Screens/drawer.dart';
import 'package:myntra/Screens/new.dart';
import 'package:myntra/Screens/talk.dart';
import 'package:myntra/Screens/trends.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class navigation extends StatefulWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/app_bar.jpg', fit: BoxFit.cover, height: 50),
      ),
      bottomNavigationBar: SalomonBottomBar(
        onTap: (i) => setState(() => screenIndex = i),
        currentIndex: screenIndex,

        items: [
          SalomonBottomBarItem(selectedColor: Colors.red, icon: Icon(Icons.home_filled), title: Text("Home")),
          SalomonBottomBarItem(selectedColor: Colors.red, icon: Icon(Icons.play_circle_outline), title: Text('Minis')),
          SalomonBottomBarItem(icon: Icon(Icons.people_alt_sharp), title: Text('Talks'), selectedColor: Colors.red),
          SalomonBottomBarItem(icon: Icon(Icons.tag), title: Text('Trends'), selectedColor: Colors.red),
          SalomonBottomBarItem(icon: Icon(Icons.person), title: Text('Profile'), selectedColor: Colors.red),
        ],
      ),
      body: _getScreen(screenIndex),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return home();
      case 1:
        return newpage();
      case 2:
        return talks();
      case 3:
        return trends();
      case 4:
        return drawer_page();
      default:
        return home();
    }
  }
}
