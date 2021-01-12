import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';

// ignore: must_be_immutable
class UpdatePost extends StatefulWidget {
  UpdatePost({this.petData});
  DocumentSnapshot petData;
  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  String petCondition;

  String petCategory;

  String petSold;

  String petName, petColor, petLocation, petDescription;

  double petAge, petWeight;

  File image;

  int timeStamp = DateTime.now().millisecondsSinceEpoch;

  var imageUrl;

  bool userLoggedIn = true;

  String uid;

  Crud crud = new Crud();

  @override
  void initState() {
    setState(() {
      uid = crud.userUid();
      imageUrl = widget.petData.get('ImageUrl');
      petName = widget.petData.get('petName');
      petColor = widget.petData.get('petColor');
      petLocation = widget.petData.get('petLocation');
      petDescription = widget.petData.get('petDescription');
      petAge = widget.petData.get('petAge');
      petWeight = widget.petData.get('petWeight');
      petCondition = widget.petData.get('petCondition');
      petCategory = widget.petData.get('petCategory');
      petSold = widget.petData.get('petSold');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () {
                _imgFromGallery().then((_) async {
                  imageUrl =
                      await crud.uploadpetImage(image, UniqueKey().toString());
                  setState(() {});
                });
              },
              child: CircleAvatar(
                backgroundImage: image == null
                    ? NetworkImage(imageUrl)
                    : NetworkImage(imageUrl),
                radius: 60,
                backgroundColor: Colors.blue[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  initialValue: petName,
                  onChanged: (value) {
                    petName = value;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.pets),
                      hintText: "Pet Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]),
                  ),
                ),
                child: TextFormField(
                  initialValue: petAge.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    petAge = double.parse(value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.arrow_upward),
                      hintText: "Pet Age",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  initialValue: petColor,
                  onChanged: (value) {
                    petColor = value;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.colorize),
                      hintText: "Pet Color",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  initialValue: petWeight.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    petWeight = double.parse(value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.line_weight),
                      hintText: "Pet Weight",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  initialValue: petLocation,
                  onChanged: (value) {
                    petLocation = value;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      hintText: "Pet Location",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[200]))),
                child: TextFormField(
                  initialValue: petDescription,
                  onChanged: (value) {
                    petDescription = value;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      hintText: "Pet Description",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pet Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: petCategory,
                        items: <String>['HAMSTER', 'CAT', 'BUNNY', 'DOG']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            petCategory = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pet Condition',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new DropdownButton<String>(
                        value: petCondition,
                        items: <String>['MATING', 'ADOPTION', 'DISAPPEAR']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            petCondition = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Pet Sold',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new DropdownButton<String>(
                        value: petSold,
                        items: <String>['Sold', 'Not Sold'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            petSold = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            FlatButton.icon(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              onPressed: () async {
                Map<String, dynamic> data = {
                  'TimeStamp': timeStamp,
                  'Uid': uid,
                  'ImageUrl': imageUrl,
                  'petName': petName,
                  'petAge': petAge,
                  'petColor': petColor,
                  'petWeight': petWeight,
                  'petLocation': petLocation,
                  'petDescription': petDescription,
                  'petCategory': petCategory,
                  'petCondition': petCondition,
                  'petSold': petSold,
                };

                await crud.updatePost(widget.petData.id, data);
                showToast();
                Get.offAll(CustomNavigation());
              },
              icon: Icon(
                Icons.file_upload,
                color: Colors.white,
              ),
              label: Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Pet Updated',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
