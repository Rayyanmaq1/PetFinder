import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Crud {
  setPetdata(data) async {
    FirebaseFirestore.instance.collection('PetData').doc().set(data);
  }

  uploadpetImage(image, imageName) async {
    var downloadUrl;
    var snapshot =
        await FirebaseStorage.instance.ref().child(imageName).putFile(image);

    await snapshot.ref.getDownloadURL().then((value) {
      downloadUrl = value;
      print(downloadUrl);
    });

    return downloadUrl;
  }

  userUid() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  getAllpetData() async {
    return await FirebaseFirestore.instance.collection('PetData').get();
  }
}
