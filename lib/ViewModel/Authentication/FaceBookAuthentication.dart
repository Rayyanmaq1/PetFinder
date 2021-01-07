import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FaceBookAuthentcation {
  Map userProfile;
  // ignore: missing_return
  Future<UserCredential> signInWithFacebook() async {
    var fbLogin = FacebookLogin();
    // ignore: unrelated_type_equality_checks
    // print(fbLogin.logIn(['email', 'public_profile']));

    var result =
        await fbLogin.logIn(['email', 'public_profile']).catchError((e) {
      print(e);
    });
    print('this');
    print(result);

    // if (result.status == FacebookLoginStatus.loggedIn) {
    FacebookAccessToken myToken = result.accessToken;
    AuthCredential credential =
        // ignore: deprecated_member_use
        FacebookAuthProvider.credential(myToken.token);

    var user = await FirebaseAuth.instance.signInWithCredential(credential);

    Map<String, dynamic> data = {
      'Image': user.user.photoURL == null ? '' : user.user.photoURL,
      'FirstName': user.user.displayName,
      'PhoneNumber': user.user.phoneNumber == null ? '' : user.user.phoneNumber,
      'Email': user.user.email,
    };
    String uid = user.user.uid;
    FirebaseFirestore.instance.collection('UserData').doc(uid).set(data);

    return user;
    // }
  }
}
