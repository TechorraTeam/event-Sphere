import 'dart:async';

import 'package:event_sphere/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;
  @override
  void initState() {
    super.initState();
    time();
  }
  void time(){
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _progressValue += 0.05; 
      });

      if (_progressValue >= 1.0) {
        timer.cancel();
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4E6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 250.0),
              child: Image.asset('assets/images/splash_screen_logo.png', height: 100),
            ), 
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: LinearProgressIndicator(
                value: _progressValue,
                minHeight: 10,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.orange, // Your logo color
                backgroundColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}