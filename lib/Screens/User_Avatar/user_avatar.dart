import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_finder/Widgets/CustomShimmer.dart';

// ignore: must_be_immutable
class UserAvatar extends StatelessWidget {
  UserAvatar({this.userData});

  DocumentSnapshot userData;
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        image: DecorationImage(
          image: userData != null
              ? userData.data().containsKey('ImageUrl')
                  ? NetworkImage(userData.get('ImageUrl'))
                  : AssetImage("assets/images/ProfilePic.png")
              : CustomShimmer(),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
