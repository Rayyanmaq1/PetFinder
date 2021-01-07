import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Screens/Authentication/Login.dart';
import 'package:pet_finder/Widgets/AltarDialog.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool userLoggedin = true;
  DocumentSnapshot userData;

  // ignore: must_call_super
  initState() {
    if (Crud().ifuserLoggedIn()) {
      Crud().currentUserData().then((value) {
        setState(() {
          userData = value;
        });
      });
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
            child: userData != null
                ? Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: DrawerHeader(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: userData
                                              .data()
                                              .containsKey('Image')
                                          ? userData
                                                      .get('Image')
                                                      .toString()
                                                      .length !=
                                                  0
                                              ? NetworkImage(
                                                  userData.get('Image'))
                                              : AssetImage(
                                                  'assets/images/ProfilePic.png')
                                          : AssetImage(
                                              'assets/images/ProFile.png'),
                                      fit: BoxFit.fill)),
                              child: Text(
                                userData.get('FirstName'),
                                style: TextStyle(color: Colors.white),
                              )),
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
                              Crud().signOut();
                              Get.offAll(Login());
                            },
                          ),
                          ListTile(
                            title: Text("Sign Out"),
                            leading: Icon(
                              Icons.logout,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              Crud().signOut();
                              Get.offAll(Login());
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
                  )
                : CustomShimmer())
        : CustomAlertDialog();
  }
}
