import 'package:event_sphere/view/screens/dashboard.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  bool isNotAuthorised = false;
  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed up!');
    } catch (e) {
      print('Sign up failed: $e');
    }
  }

  login(email, password) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isNotAuthorised = false;
      update();
      Get.to(DashboardScreen());

    } on FirebaseAuthException catch (e) {
      isNotAuthorised = true;
      update();
      print(e.message);
    }
  }
}
