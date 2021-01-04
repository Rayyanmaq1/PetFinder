import 'package:flutter/material.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentSnapshot userData;
  String uid;
  void initState() {
    uid = Crud().userUid();
    Crud().currentUserData().then((value) {
      setState(() {
        userData = value;
      });
    });
    super.initState();
  }

  TextStyle textStyle =
      TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userData != null
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromRGBO(0, 0, 70, 1),
                    Color.fromRGBO(28, 181, 224, 1),
                    Colors.blue,
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  CircleAvatar(
                    radius: 60,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Name',
                                            style: textStyle,
                                          ),
                                          Text(userData.get('FirstName') +
                                              ' ' +
                                              userData.get('SecondName'))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Email',
                                            style: textStyle,
                                          ),
                                          Text(userData.get('Email'))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Phone Number',
                                            style: textStyle,
                                          ),
                                          FutureBuilder(
                                              future: FirebaseFirestore.instance
                                                  .collection('UserData')
                                                  .doc(uid)
                                                  .get(),
                                              builder: (context, snapshot) {}),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : CustomShimmer(),
    );
  }
}
