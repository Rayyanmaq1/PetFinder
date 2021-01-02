import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GmailAuthentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  registerWithGmail() async {
    final GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth =
        await _signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);

    final User user =
        await _auth.signInWithCredential(credential).then((value) {
      return value.user;
    });

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
  }
}
