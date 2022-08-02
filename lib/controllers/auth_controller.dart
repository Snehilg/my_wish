import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_wish/utils.dart';

class AuthController extends GetxController {
  RxString tab = "Login".obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  changeTab(value) {
    tab.value = value;
  }

  registerUser(String email, String password, String username) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;

    if (user != null) {
      userCollection.doc(user.uid).set({
        "email": email,
        "username": username,
      });
    }
  }

  loginUser(String email, String password) async {
    try {
      firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("failed to login");
    }
  }
}
