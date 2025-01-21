import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_sphere/model/user_data_model.dart';
import 'package:event_sphere/view/screens/Login_Screen.dart';
import 'package:event_sphere/view/screens/dashboard.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  bool isNotAuthorised = false;
  List<UserDataModel> userModel = [];
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
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('users').get();
      List<DocumentSnapshot> allData = data.docs;
      Get.off(DashboardScreen());

      for (var data in allData) {
        userModel.add(UserDataModel.fromDocumentSnapshot(data));
      }
      update();
      Get.off(DashboardScreen());
    } on FirebaseAuthException catch (e) {
      isNotAuthorised = true;
      update();
      print(e.message);
    }
  }

  void logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> addUserToDatabase(
    String username,
    String email,
    String gender,
  ) async {
    final userID = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection("users").doc(userID!.uid);
    final userDataModel = UserDataModel(
      name: username,
      email: email,
      gender: gender,
      id: userID.uid,
    );
    await docRef.set(userDataModel.toMap());
    // usingUserDataModel(userDataModel);
    // update();
  }

  Future<void> fetchingUserDataFromFireStore() async {
    final userId = FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot docRef = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId!.uid)
          .get();

      if (docRef.exists) {
        UserDataModel userData = UserDataModel.fromDocumentSnapshot(docRef);
        userModel = [userData];
        update();
      } else {
        Get.snackbar("Error", "User not found.");
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error", "$e");
    }
  }

  // usingUserDataModel(UserDataModel userDataModel) {
  //   userModel.add(userDataModel);
  //   update();
  // }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
    } catch (e) {
      print('Error: $e');
    }
  }

  checkUserExists() {
    if (FirebaseAuth.instance.currentUser != null) {
      Get.off(DashboardScreen());
    } else {
      Get.off(LoginScreen());
    }
  }
}
