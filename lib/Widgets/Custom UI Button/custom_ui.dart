import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGui {
  static Widget customButton(String text, Function() onPressed) {
    return Container(
        height: 45.h,
        width: 280.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            elevation: 3, // Shadow elevation
            padding:
                EdgeInsets.symmetric(horizontal: 50, vertical: 10), // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Rounded corners
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  static Widget customFormField(String labelText, String validatorText,
      bool isPasswordType, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color(0x000000),
          ),
        ),
      ),
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      validator: (value) {
        if (value == null) {
          return validatorText;
        }
        return null;
      },
    );
  }

  static Widget textField(TextEditingController controller, String text) {
    return Container(
        height: 45.h,
        width: 280.w,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            hintText: 'Enter your $text',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontStyle: FontStyle.italic,
            ),
            border: OutlineInputBorder(
              // Default border
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
          ),
        ));
  }

  static Widget genderRadio(ValueNotifier<String> selectedGender) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedGender,
      builder: (context, value, child) {
        return Row(
          children: [
            Radio<String>(
              value: "Male",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Male"),
            Radio<String>(
              value: "Female",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Female"),
            Radio<String>(
              value: "Other",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Other"),
          ],
        );
      },
    );
  }

  static final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
