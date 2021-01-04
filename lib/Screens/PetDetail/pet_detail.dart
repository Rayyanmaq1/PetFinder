import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Screens/User_Avatar/user_avatar.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';

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
  @override
  // ignore: must_call_super
  initState() {
    Crud().checkFavourite(widget.pet.id).then((value) {
      setState(() {
        userFavourite = value;
        Crud().userPostedinfo(pet.id).then((value) {
          setState(() {
            postedInfo = value;
          });
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: widget.pet.get('ImageUrl'),
                  child: Container(
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
                              fontSize: 24,
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
                              Text(
                                widget.pet.get('petLocation'),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
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
                        height: 50,
                        width: 50,
                        child: userFavourite != null
                            ? GestureDetector(
                                onTap: () {
                                  Crud().favourite(widget.pet.id).then((_) {
                                    setState(() {
                                      initState();
                                    });
                                  });
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: userFavourite.get('State')
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 28,
                                ),
                              )
                            : CustomShimmer(),
                      ),
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
                          UserAvatar(),
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
                                      postedInfo.get('FirstName') +
                                          ' ' +
                                          postedInfo.get('SecondName'),
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
                        child: Text(
                          "Contact Me",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
        height: 70,
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
                fontSize: 16,
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
}
