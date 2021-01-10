import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Screens/Authentication/Login.dart';
import 'package:pet_finder/Screens/Favourite/Favourite.dart';
import 'package:pet_finder/Screens/HomePage/principal.dart';
import 'package:pet_finder/Screens/Profile/Profile.dart';
import 'package:pet_finder/Model/crud.dart';

class CustomNavigation extends StatefulWidget {
  @override
  _CustomNavigationState createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  PageController controller = PageController();
  List<Widget> pageList = List<Widget>();
  int index;
  bool userStatus = false;
  int _selectedPage = 1;
  @override
  void initState() {
    pageList.add(Favourite());
    pageList.add(Principal());
    pageList.add(Profile());
    Crud().userStatus().then((value) {
      setState(() {
        userStatus = value.exists;
      });
    });

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

        body: userStatus == false
            ? pageList[_selectedPage]
            : AlertDialog(
                title: Text('You are Blocked'),
                content: Text(
                    'You have been blocked by user for some issue Logout or login from another account'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Crud().signOut();
                        Get.offAll(Login());
                      },
                      child: Text('LogOut'))
                ],
              ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      Crud().userStatus().then((value) {
        userStatus = value.exists;
      });
    });
  }
}
