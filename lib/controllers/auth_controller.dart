import 'package:firebase_auth/firebase_auth.dart';

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
        .then((result)async => {
          if(result.user != null){
            await result.user!.updateDisplayName(name)
          } 
        }
        );

    return true;
  }
}
