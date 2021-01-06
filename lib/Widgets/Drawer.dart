import 'package:flutter/material.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Widgets/AltarDialog.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool userLoggedin = true;

  // ignore: must_call_super
  initState() {
    if (Crud().ifuserLoggedIn()) {
    } else {
      setState(() {
        userLoggedin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userLoggedin
        ? Drawer(
            child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/cat.png"),
                            fit: BoxFit.cover)),
                    child: Text("Header"),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView(children: [
                  ListTile(
                    title: Text("Sign In With Other Account"),
                    leading: Icon(
                      Icons.login,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text("Sign Out"),
                    leading: Icon(
                      Icons.logout,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Rate Us"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    leading: Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    title: Text("Share"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    leading: Icon(
                      Icons.share,
                      color: Colors.blue,
                    ),
                  ),
                ]),
              )
            ],
          ))
        : CustomAlertDialog();
  }
}
