import 'package:flutter/material.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Screens/Pet_Widget/pet_widget.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  int totalPage;
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

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
                    backgroundImage: userData.data().containsKey('Image')
                        ? NetworkImage(userData.get('Image'))
                        : AssetImage('assets/images/ProfilePic.png'),
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
                                          userData
                                                  .data()
                                                  .containsKey('PhoneNumber')
                                              ? Text(
                                                  userData.get('PhoneNumber'))
                                              : Text('-'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Center(
                                          child: Text(
                                        'Your Posts',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        height: 270,
                                        child: FutureBuilder(
                                          future: FirebaseFirestore.instance
                                              .collection('PetData')
                                              .where('Uid', isEqualTo: uid)
                                              .get(),
                                          builder: (context, snapshot) {
                                            if (ConnectionState.waiting ==
                                                snapshot.connectionState) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else {
                                              return PageView.builder(
                                                  controller: controller,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      snapshot.data.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 250,
                                                      child: PetWidget(
                                                          pet: snapshot
                                                              .data.docs[index],
                                                          index: index),
                                                    );
                                                  });
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: SmoothPageIndicator(
                                            effect: WormEffect(),
                                            onDotClicked: (index) {
                                              controller.animateToPage(index,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.easeInCubic);
                                            },
                                            controller: controller,
                                            count: 3),
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
