import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'pages/navHomeScreen.dart';
import 'pages/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<MyDrawerController>(MyDrawerController());

  /*SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky).then(
        (_) => runApp(const MyApp()),
  );*/
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tree Donate',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black
      ),

      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



