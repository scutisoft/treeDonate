import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/navHomeScreen.dart';
import 'pages/splashScreen.dart';

void main() {
  Get.put<MyDrawerController>(MyDrawerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tree Donate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



