import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_finder/Model/crud.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';

// ignore: must_be_immutable
class UpdateUserProfile extends StatefulWidget {
  UpdateUserProfile({this.userData});
  DocumentSnapshot userData;
  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  String name;
  String phoneNumber;
  String imageUrl;
  File fileImage;
  @override
  void initState() {
    setState(() {
      name = widget.userData.get('FirstName');

      phoneNumber = widget.userData.data().containsKey('PhoneNumber')
          ? widget.userData.get('PhoneNumber')
          : '';
      imageUrl = widget.userData.data().containsKey('Image')
          ? widget.userData.get('Image')
          : 'assets/images/ProfilePic.png';
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
              height: 100,
            ),
            GestureDetector(
              onTap: () {
                _imgFromGallery().then((_) async {
                  imageUrl = await Crud()
                      .uploadpetImage(fileImage, UniqueKey().toString());
                  setState(() {});
                });
              },
              child: CircleAvatar(
                backgroundImage: imageUrl.length == 28
                    ? AssetImage(imageUrl)
                    : imageUrl.toString().length != 0
                        ? NetworkImage(imageUrl)
                        : AssetImage('assets/images/ProfilePic.png'),
                radius: 60,
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
                  initialValue: name,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Name",
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
                  initialValue: phoneNumber,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton.icon(
              padding: EdgeInsets.all(8),
              onPressed: () {
                String uid = Crud().userUid();
                Map<String, dynamic> data = {
                  'Image': imageUrl,
                  'FirstName': name,
                  'PhoneNumber': phoneNumber,
                };
                Crud().updateProfile(uid, data);
                showToast();
                Get.offAll(CustomNavigation());
              },
              icon: Icon(
                Icons.update,
                color: Colors.blue[900],
              ),
              label: Text('Update'),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    fileImage = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50));
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Profile Updated',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
