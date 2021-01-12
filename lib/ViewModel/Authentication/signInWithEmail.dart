import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';
import 'package:pet_finder/ViewModel/AuthException.dart';

class EmailSignIn {
  signInWithEmail(_email, _password, firstName, phoneNumber) async {
    Map<String, dynamic> data = {
      'FirstName': firstName,
      'PhoneNumber': phoneNumber,
      'Email': _email,
      'Image': '',
    };
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((user) {
      FirebaseFirestore.instance
          .collection('UserData')
          .doc(user.user.uid)
          .set(data);
      Get.offAll(CustomNavigation());
    }).catchError((e) {
      print(e);
      AuthExceptionHandler.handleException(e);
    });
  }
}
