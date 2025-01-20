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

  static Widget customFormField(String labelText, String validatorText) {
    return TextFormField(
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
      validator: (value) {
        if (value == null) {
          return validatorText;
        }
        return null;
      },
    );
  }
}
