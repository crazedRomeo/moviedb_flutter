import 'package:flutter/material.dart';
import 'package:test/database/index.dart';
import 'package:test/views/favourite.dart';
import 'package:test/views/home.dart';
import 'package:test/views/search.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) {
  }

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool changed=false;
  int _selectedIndex = 0;
  String title="home";
  final _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }
  void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        switch(index){
          case 0:setState(() {
            title="home";
          });break;
          case 1:setState(() {
            title="favorite";
          });break;
          case 2:setState(() {
            title="search";
          });break;
        }
      });
      _pageController.animateToPage(index, duration: const Duration(microseconds: 300),curve: Curves.easeIn);
    }
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text(title),
      ),
      backgroundColor:Colors.white,
      key: scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children:  [
          HomeScreen(),
          FavouriteScreen(),
          SearchScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
