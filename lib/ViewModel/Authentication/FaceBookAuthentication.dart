// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// class FaceBookAuthentcation {
//   Map userProfile;
//   final facebookLogin = FacebookLogin();
//   Future<UserCredential> signInWithFacebook() async {
//     // Trigger the sign-in flow
//     final result = await FaceBookAuthentcation().facebookLogin.logIn(['email']);

//     // Create a credential from the access token
//     final FacebookAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(result.accessToken.token);

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance
//         .signInWithCredential(facebookAuthCredential);
//   }
// }
