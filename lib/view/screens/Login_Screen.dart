import 'package:event_sphere/view/widgets/custon_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300.w,
                  height: 80.h,
                  child: Image.asset('assets/Event Sphere Logo.png')),
              SizedBox(height: 80.h,),
              Padding(
                padding:  EdgeInsets.only(left: 40.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))),
              ),
              SizedBox(height: 16.h,),
              CustomGui.textField(emailController,'Email'),
              SizedBox(height: 10.h,),
              CustomGui.textField(passwordController,'Password'),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.only(right: 40.w),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Don\'t already have an account?',style: TextStyle(fontSize: 10),),
                    SizedBox(width: 5,),
                    GestureDetector(child: Text('Sign up instead',style: TextStyle(fontSize: 10,color: Colors.orange,fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
              SizedBox(height: 40.h,),
              CustomGui.customButton('Login', () {}),
              
            ],
          ),
        ),
      ),
    );
  }
}
