<<<<<<< HEAD
import 'package:event_sphere/View/SignUp/singup.dart';
import 'package:flutter/material.dart';
=======
import 'package:event_sphere/view/screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
>>>>>>> 07cac5466fed8ea3a58227c5378f0eed01a67ef6
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Singup(),
=======
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: (context, widget) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:
              //TestingFile(),
              LoginScreen(),
        );
      },
>>>>>>> 07cac5466fed8ea3a58227c5378f0eed01a67ef6
    );
  }
}
