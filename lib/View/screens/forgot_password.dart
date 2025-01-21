import 'package:event_sphere/Widgets/Custom%20UI%20Button/custom_ui.dart';
import 'package:event_sphere/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    TextEditingController emailController = TextEditingController();
    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 300.w,
                    height: 80.h,
                    child: Image.asset('assets/images/Event Sphere Logo.png')),
                SizedBox(
                  height: 80.h,
                ),
                CustomGui.textField(emailController, 'Email'),
                SizedBox(
                  height: 20.h,
                ),
                CustomGui.customButton('Send', () async {
                  if (emailController.text.isNotEmpty) {
                    await authController
                        .sendPasswordResetEmail(emailController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password reset email sent!')),
                    );
                    Get.back();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter an email')),
                    );
                  }
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
