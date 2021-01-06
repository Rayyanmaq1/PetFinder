import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pet_finder/Screens/Favourite/Favourite.dart';
import 'package:pet_finder/Screens/HomePage/principal.dart';
import 'package:pet_finder/Screens/Profile/Profile.dart';

class CustomNavigation extends StatefulWidget {
  @override
  _CustomNavigationState createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  PageController controller = PageController();
  List<Widget> pageList = List<Widget>();
  int index;
  int _selectedPage = 1;
  @override
  void initState() {
    pageList.add(Favourite());
    pageList.add(Principal());
    pageList.add(Profile());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: ("favourite"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ("Profile"),
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ), // This trailing comma makes auto-formatting nicer for build methods.

        body: IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
