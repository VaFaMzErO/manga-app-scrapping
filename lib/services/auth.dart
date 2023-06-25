import 'package:firebase_auth/firebase_auth.dart';
import 'package:manga_reader/models/myuser.dart';

class AuthService {
   FirebaseAuth _auth = FirebaseAuth.instance;
  // sign in
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
