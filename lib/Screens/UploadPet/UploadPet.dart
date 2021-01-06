import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Widgets/AltarDialog.dart';

class UploadPet extends StatefulWidget {
  @override
  _UploadPetState createState() => _UploadPetState();
}

class _UploadPetState extends State<UploadPet> {
  // ignore: must_call_super
  void initState() {
    if (crud.ifuserLoggedIn()) {
      setState(() {
        uid = crud.userUid();
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
                    child: CircleAvatar(
                      backgroundImage: imageUrl == null
                          ? AssetImage('assets/images/cat.png')
                          : NetworkImage(imageUrl.toString()),
                      radius: 60,
                      backgroundColor: Colors.blue[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                      padding: EdgeInsets.symmetric(horizontal: 10),
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pet Category',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new DropdownButton<String>(
                              value: petCondition,
                              items: <String>['MATING', 'ADOPTION', 'DISAPPER']
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

                      await crud.setPetdata(data).then((_) {
                        showToast();
                        Navigator.pop(context);
                      });
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
