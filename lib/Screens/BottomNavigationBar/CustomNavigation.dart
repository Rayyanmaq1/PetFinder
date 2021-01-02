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
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [Favourite(), Principal(), Profile()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.favorite),
          title: ("favourite"),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("Profile"),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey),
    ];
  }
}
