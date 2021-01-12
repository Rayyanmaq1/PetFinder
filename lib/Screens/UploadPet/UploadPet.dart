import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Widgets/AltarDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadPet extends StatefulWidget {
  @override
  _UploadPetState createState() => _UploadPetState();
}

class _UploadPetState extends State<UploadPet> {
  DocumentSnapshot userData;
  // ignore: must_call_super
  void initState() {
    if (crud.ifuserLoggedIn()) {
      crud.currentUserData().then((value) {
        setState(() {
          userData = value;
        });
      });
    } else {
      setState(() {
        userLoggedIn = false;
      });
    }
  }

  String petCondition = 'MATING';
  String petCategory = 'CAT';
  String petSold = 'Not Sold';
  String petName, petColor, petLocation, petDescription;
  double petAge, petWeight;
  File image;
  int timeStamp = DateTime.now().millisecondsSinceEpoch;
  var imageUrl;
  bool userLoggedIn = true;
  String uid;
  Crud crud = new Crud();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userLoggedIn
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      _imgFromGallery().then((_) async {
                        imageUrl = await crud.uploadpetImage(
                            image, UniqueKey().toString());
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Container(
                        child: Icon(
                          Icons.camera_alt,
                          size: 25,
                          color: Colors.black45,
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                spreadRadius: 3,
                                offset: Offset(3, 4),
                                color: Colors.grey)
                          ],
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: imageUrl == null
                                ? AssetImage('assets/images/cat.png')
                                : NetworkImage(imageUrl.toString()),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
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
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[200]),
                        ),
                      ),
                      child: TextField(
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
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
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
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
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
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
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
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: TextField(
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
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pet Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              DropdownButton<String>(
                                value: petCategory,
                                items: <String>[
                                  'HAMSTER',
                                  'CAT',
                                  'BUNNY',
                                  'DOG'
                                ].map((String value) {
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pet Condition',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              new DropdownButton<String>(
                                value: petCondition,
                                items: <String>[
                                  'MATING',
                                  'ADOPTION',
                                  'DISAPPEAR'
                                ].map((String value) {
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Pet Sold',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              new DropdownButton<String>(
                                value: petSold,
                                items: <String>['Sold', 'Not Sold']
                                    .map((String value) {
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton.icon(
                    padding: EdgeInsets.all(10),
                    color: Colors.blue,
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        'TimeStamp': timeStamp,
                        'Uid': userData.id,
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

                      if (imageUrl != null &&
                          petName != null &&
                          petAge != null &&
                          petColor != null &&
                          petWeight != null &&
                          petLocation != null &&
                          petDescription != null) {
                        if (userData.get('PhoneNumber').toString().length !=
                            0) {
                          print(userData.get('PhoneNumber'));
                          await crud.setPetdata(data).then((_) {
                            showToast();
                            Navigator.pop(context);
                          });
                        } else {
                          print(userData.get('PhoneNumber'));
                          showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Enter Your Phone Number'),
                                actions: [
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'))
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: (context),
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Invalid Input'),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Try Agin'))
                              ],
                            );
                          },
                        );
                      }
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
            )
          : CustomAlertDialog(),
    );
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Pet Uploaded',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
