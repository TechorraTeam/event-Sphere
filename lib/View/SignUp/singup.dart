import 'package:event_sphere/View/screens/dashboard.dart';
import 'package:event_sphere/controller/auth_controller.dart';
import 'package:event_sphere/Resources/Images/assets_images.dart';
import 'package:event_sphere/View/screens/Login_Screen.dart';
import 'package:event_sphere/Widgets/Custom%20UI%20Button/custom_ui.dart';
import 'package:event_sphere/controller/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    final ImagePickerController controller = Get.put(ImagePickerController());

    final ValueNotifier<String> selectedGender = ValueNotifier<String>("");

    TextEditingController username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AssetsImages.eventSphereLogo,
                  width: 300, height: 200),
              Row(
                children: [
                  Text(
                    "SignUp",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display the selected image using Obx
                  Obx(() {
                    return controller.selectedImage.value != null
                        ? CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                FileImage(controller.selectedImage.value!),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.person,
                                size: 60, color: Colors.white),
                          );
                  }),
                  SizedBox(height: 20),
                  CustomGui.customButton("Select Profile Picture", () {
                    controller.pickImage();
                  })
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomGui.customFormField(
                  "UserName", "Please Enter Username.", false, username),
              SizedBox(
                height: 8,
              ),
              CustomGui.customFormField(
                  "Email", "Please Enter Email.", false, email),
              SizedBox(
                height: 8,
              ),
              CustomGui.customFormField(
                  "Password", "Please Enter Password.", true, password),
              SizedBox(
                height: 8,
              ),
              CustomGui.customFormField("Confirm Password",
                  "Please Enter Confirm Password.", true, confirmPassword),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text("Select Gender"),
                ],
              ),
              CustomGui.genderRadio(selectedGender),
              SizedBox(height: 20),
              CustomGui.customButton(
                "SignUp",
                () {
                  if (!CustomGui.emailRegex.hasMatch(email.text)) {
                    Get.snackbar("Error", "Enter Valid Email.");
                  } else if (password.text != confirmPassword.text) {
                    Get.snackbar("Error", "Invalid password match.");
                  } else if (email.text.isNotEmpty ||
                      password.text.isNotEmpty) {
                    authController.signUp(email.text, password.text).then((_) {
                      authController.addUserToDatabase(
                        username.text,
                        email.text,
                        selectedGender.value,
                      );
                    }).then((_) {
                      Get.offAll(() => DashboardScreen());
                    });

                    print("Successfully created account.");
                  } else {
                    Get.snackbar("Error", 'Please Enter Email and Password');
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 10),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => LoginScreen(),
                        );
                      },
                      child: Text(
                        "Login Instead.",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
