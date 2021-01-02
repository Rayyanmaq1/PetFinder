import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserLogin {
  emailLogin(email, password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.popAndPushNamed(context, '/home');
    });
  }
}
