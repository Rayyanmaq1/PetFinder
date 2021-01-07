import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Screens/Authentication/Login.dart';

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sign In'),
      content: Text('Sign In to see all feactures'),
      actions: [
        FlatButton(
          onPressed: () {
            Get.offAll(Login());
          },
          child: Text('Sign In'),
        ),
      ],
    );
  }
}
