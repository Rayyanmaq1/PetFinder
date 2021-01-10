import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';
import 'package:pet_finder/ViewModel/AuthException.dart';

class UserLogin {
  emailLogin(email, password, context) async {
    var _status;
    try {
      final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
        Get.offAll(CustomNavigation());
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }
}
