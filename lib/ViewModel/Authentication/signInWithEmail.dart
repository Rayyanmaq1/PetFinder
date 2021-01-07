import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailSignIn {
  signInWithEmail(_email, _password, firstName, phoneNumber) async {
    Map<String, dynamic> data = {
      'FirstName': firstName,
      'PhoeneNumber': phoneNumber,
      'Email': _email,
      'Image': ''
    };
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((user) {
      FirebaseFirestore.instance
          .collection('UserData')
          .doc(user.user.uid)
          .set(data);
    });
  }
}
