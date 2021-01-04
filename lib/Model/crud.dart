import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Crud {
  setPetdata(data) async {
    FirebaseFirestore.instance.collection('PetData').doc().set(data);
  }

  getPetDataforCategory(category) async {
    return await FirebaseFirestore.instance
        .collection('PetData')
        .where('petCategory', isEqualTo: category)
        .get();
  }

  uploadpetImage(image, imageName) async {
    var downloadUrl;
    var snapshot =
        await FirebaseStorage.instance.ref().child(imageName).putFile(image);

    await snapshot.ref.getDownloadURL().then((value) {
      downloadUrl = value;
    });

    return downloadUrl;
  }

  userUid() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  getAllpetData() async {
    return await FirebaseFirestore.instance
        .collection('PetData')
        .orderBy('TimeStamp', descending: false)
        .get();
  }

  currentUserData() async {
    String uid = userUid();

    return await FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
        .get();
  }

  getAllpets() async {
    return FirebaseFirestore.instance.collection('PetData').snapshots();
  }

  checkFavourite(postID) async {
    String uid = userUid();
    return await FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
        .collection('Favourite')
        .doc(postID)
        .get();
  }

  getPetDataforFav() async {
    return await FirebaseFirestore.instance.collection('PetData').get();
  }

  userPostedinfo(postId) async {
    DocumentSnapshot userData;
    await FirebaseFirestore.instance
        .collection('PetData')
        .doc(postId)
        .get()
        .then((value) async {
      userData = await FirebaseFirestore.instance
          .collection('UserData')
          .doc(value.get('Uid'))
          .get();
    });
    return userData;
  }

  getFavouriteList() async {
    String uid = userUid();
    return FirebaseFirestore.instance
        .collection('UserData')
        .doc(uid)
        .collection('Favourite')
        .snapshots();
  }

  checkiffavExist() async {
    QuerySnapshot data;

    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(userUid())
        .collection('Favourite')
        .where('State', isEqualTo: true)
        .get()
        .then((value) {
      data = value;
    });

    if (data.docs.length == 0) {
      return 'false';
    } else {
      return 'true';
    }
  }

  favourite(postID) async {
    String currentUid = userUid();
    Map<String, dynamic> makeTrue = {'State': true};
    Map<String, dynamic> makeFalse = {'State': false};

    // ignore: await_only_futures
    DocumentReference fav = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(currentUid)
        .collection('Favourite')
        .doc(postID);
    DocumentSnapshot data = await fav.get();

    if (data.exists) {
      fav.set(makeFalse);
      if (data.get('State') == false) {
        fav.set(makeTrue);
      }
    } else {
      fav.set(makeTrue);
    }
  }
}
