import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Screens/Pet_Widget/pet_widget.dart';
import 'package:pet_finder/Screens/Update/UpdateProfile.dart';
import 'package:pet_finder/ViewModel/SizeConfig.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pet_finder/Widgets/AltarDialog.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentSnapshot userData;
  String uid;
  QuerySnapshot posts;
  var totalPages = 0;
  bool userLoggedIn = true;

  void initState() {
    if (Crud().ifuserLoggedIn()) {
      Crud().currentUserData().then((value) {
        setState(() {
          userData = value;
        });
        Crud().currentUsersPosts().then((value) {
          setState(() {
            posts = value;
          });
        });
      });
    } else {
      setState(() {
        userLoggedIn = false;
      });
    }
    super.initState();
  }

  TextStyle textStyle =
      TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);
  int totalPage;
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    return Scaffold(
      body: userLoggedIn
          ? userData != null
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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: userData
                                        .get('Image')
                                        .toString()
                                        .length !=
                                    0
                                ? NetworkImage(userData.get('Image'))
                                : AssetImage('assets/images/ProfilePic.png'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(UpdateUserProfile(
                                userData: userData,
                              ));
                            },
                            child: Container(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              ),
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                              Text(userData.get('FirstName'))
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
                                              Text(userData.get('PhoneNumber')),
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
                                            height: 20,
                                          ),
                                          Container(
                                            height:
                                                SizeConfig.heightMultiplier *
                                                    33,
                                            child: FutureBuilder(
                                              future:
                                                  Crud().currentUsersPosts(),
                                              builder: (context, snapshot) {
                                                if (ConnectionState.waiting ==
                                                    snapshot.connectionState) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else {
                                                  if (snapshot
                                                          .data.docs.length ==
                                                      0) {
                                                    return Center(
                                                      child: Container(
                                                        child: Text(
                                                            'No Posts Avaliable'),
                                                      ),
                                                    );
                                                  } else {
                                                    return PageView.builder(
                                                      controller: controller,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: snapshot
                                                          .data.docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          height: 250,
                                                          child: PetWidget(
                                                              pet: snapshot.data
                                                                  .docs[index],
                                                              index: index),
                                                        );
                                                      },
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                          posts != null
                                              ? posts.docs.length != 0
                                                  ? Center(
                                                      child: Container(
                                                        child:
                                                            SmoothPageIndicator(
                                                                effect: SwapEffect(
                                                                    dotHeight:
                                                                        8,
                                                                    dotWidth: 8,
                                                                    activeDotColor:
                                                                        Colors.grey[
                                                                            600],
                                                                    dotColor:
                                                                        Colors.grey[
                                                                            300]),
                                                                onDotClicked:
                                                                    (index) {
                                                                  controller.animateToPage(
                                                                      index,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              200),
                                                                      curve: Curves
                                                                          .easeInCubic);
                                                                },
                                                                controller:
                                                                    controller,
                                                                count: posts
                                                                    .docs
                                                                    .length),
                                                      ),
                                                    )
                                                  : Container()
                                              : CustomShimmer(),
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
              : CustomShimmer()
          : CustomAlertDialog(),
    );
  }
}
