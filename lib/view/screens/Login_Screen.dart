import 'package:event_sphere/Widgets/Custom%20UI%20Button/custom_ui.dart';
import 'package:event_sphere/controller/auth_controller.dart';
import 'package:event_sphere/view/SignUp/singup.dart';
import 'package:event_sphere/view/screens/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<AuthController>(
      builder: (authController) {
        return Center(
          child: SingleChildScrollView(
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
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Login',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          authController.isNotAuthorised
                              ? Text(
                                  'Incorrect email or password',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.red),
                                )
                              : Container(),
                        ],
                      )),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomGui.textField(emailController, 'Email'),
                SizedBox(
                  height: 10.h,
                ),
                CustomGui.textField(passwordController, 'Password'),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 185.w),
                  child: GestureDetector(
                      onTap: () async {
                        Get.to(ForgotPassword());
                      },
                      child: Text('Forgot Password?',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.orange,
                              fontWeight: FontWeight.w500))),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomGui.customButton('Login', () {
                  authController.login(
                      emailController.text, passwordController.text);
                }),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account yet?',
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(Singup());
                        },
                        child: Text('Sign up instead',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500))),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
