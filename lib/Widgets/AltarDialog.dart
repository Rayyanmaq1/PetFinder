import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sign In'),
      content: Text('Sign In to see all feactures'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/Login');
          },
          child: Text('Sign In'),
        ),
      ],
    );
  }
}
