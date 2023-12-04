import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> register(String name, String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((result) async => {
              if (result.user != null)
                {await result.user!.updateDisplayName(name)}
            });

    return true;
  }

  Future? updateProfilePicture(File file) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref();
    final pfpRef =
        ref.child('profile_pictures/${FirebaseAuth.instance.currentUser!.uid}');

    try {
      final uploadTask = await pfpRef.putFile(
          file,
          SettableMetadata(
            contentType: "image/jpeg",
          ));
      final url = await uploadTask.ref.getDownloadURL();
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
    } catch (e) {
      print(e);
    }
  }
}
