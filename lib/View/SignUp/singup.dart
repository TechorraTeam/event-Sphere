import 'package:event_sphere/Resources/Images/assets_images.dart';
import 'package:event_sphere/Widgets/Custom%20UI%20Button/custom_ui.dart';
import 'package:flutter/material.dart';

class Singup extends StatelessWidget {
  const Singup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            children: [
              Image.asset(AssetsImages.eventSphereLogo,
                  width: 300, height: 300),
              Row(
                children: [
                  Text(
                    "SignUp",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomGui.customFormField("UserName", "Please Enter Username."),
              SizedBox(
                height: 8,
              ),
              CustomGui.customFormField("Email", "Please Enter Email."),
              SizedBox(
                height: 8,
              ),
              CustomGui.customFormField("Password", "Please Enter Password."),
              SizedBox(
                height: 8,
              ),
              CustomGui.customFormField(
                  "Confirm Password", "Please Enter Confirm Password."),
              SizedBox(
                height: 15,
              ),
              CustomGui.customButton(
                "SignUp",
                () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
