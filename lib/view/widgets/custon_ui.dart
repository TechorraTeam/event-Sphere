import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGui{
  static Widget customButton(String text, Function() onPressed) {
    return Container(
      height: 45.h,
      width: 280.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, 
        elevation: 3, // Shadow elevation
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10), // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // Rounded corners
        ),
      ),
        child: Text(text,style: TextStyle(color: Colors.white),),
      )
    );
  }
}