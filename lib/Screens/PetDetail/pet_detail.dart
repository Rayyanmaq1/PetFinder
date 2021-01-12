import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';
import 'package:pet_finder/Screens/Update/UpdatePost.dart';
import 'package:pet_finder/Screens/User_Avatar/user_avatar.dart';
import 'package:pet_finder/ViewModel/SizeConfig.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetail extends StatefulWidget {
  final DocumentSnapshot pet;

  PetDetail({@required this.pet});

  @override
  _PetDetailState createState() => _PetDetailState(pet: pet);
}

class _PetDetailState extends State<PetDetail> {
  final DocumentSnapshot pet;
  _PetDetailState({this.pet});
  DocumentSnapshot userFavourite;
  DocumentSnapshot postedInfo;
  bool isuserLoggedIn = true;
  String uid;
  @override
  // ignore: must_call_super
  initState() {
    Crud().userPostedinfo(pet.id).then((value) {
      setState(() {
        postedInfo = value;
      });
    });
    if (Crud().ifuserLoggedIn()) {
      uid = Crud().userUid();
      Crud().checkFavourite(widget.pet.id).then((value) {
        setState(() {
          userFavourite = value;
        });
      });
    } else {
      setState(() {
        isuserLoggedIn = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          pet.get('Uid') == uid
              ? Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      dialog(pet.id);
                    },
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey[800],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.pet.get('ImageUrl')),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.pet.get('petName'),
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.textMultiplier * 3.0,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.7),
                                child: Text(
                                  widget.pet.get('petLocation'),
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                        ),
                        height: SizeConfig.heightMultiplier * 6,
                        width: SizeConfig.widthMultiplier * 12,
                        child: userFavourite != null
                            ? GestureDetector(
                                onTap: () {
                                  Crud().favourite(widget.pet.id).then((_) {
                                    setState(() {
                                      initState();
                                    });
                                  });
                                },
                                child: userFavourite != null
                                    ? Icon(
                                        Icons.favorite,
                                        color: userFavourite.exists
                                            ? userFavourite.get('State')
                                                ? Colors.red
                                                : Colors.grey
                                            : Colors.grey,
                                        size: 22,
                                      )
                                    : CustomShimmer(),
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.grey,
                                size: 22,
                              ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      buildPetFeature(pet.get('petAge').toString(), "Age"),
                      buildPetFeature(pet.get('petColor'), "Color"),
                      buildPetFeature(
                          pet.get('petWeight').toString(), "Weight"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Pet Story",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    (widget.pet.get('petDescription')),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          postedInfo != null
                              ? UserAvatar(
                                  userData: postedInfo,
                                )
                              : Shimmer.fromColors(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  baseColor: Colors.white,
                                  highlightColor: Colors.grey[100],
                                  direction: ShimmerDirection.ltr,
                                ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Posted by",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              postedInfo != null
                                  ? Text(
                                      postedInfo.get('FirstName'),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    )
                                  : CustomShimmer(),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue[300].withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: Colors.blue[300],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _textme();
                          },
                          child: Text(
                            "Contact Me",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildPetFeature(String value, String feature) {
    return Expanded(
      child: Container(
        height: SizeConfig.heightMultiplier * 9,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: SizeConfig.textMultiplier * 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              feature,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dialog(postId) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Post'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.update,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Get.to(UpdatePost(
                      petData: pet,
                    ));
                  },
                  title: Text('Update'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    Crud().deletePost(postId);
                    toast();
                    Get.offAll(CustomNavigation());
                  },
                  title: Text('Delete'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void toast() {
    Fluttertoast.showToast(
        msg: "Post Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _textme() async {
    String userNumber = postedInfo.get('PhoneNumber');
    String uri = 'sms:$userNumber?body=hello%20there';
    await launch(uri);
  }
}
