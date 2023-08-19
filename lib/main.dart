import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:project/authController.dart';
import 'package:project/login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   // Initialize Firebase before running the app
  await Firebase.initializeApp()
      .then((value) => Get.put(AuthController())); // dependency injection
  
  // Run the app
  runApp(const MyApp());

  // Load environment variables from .env file
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rest API',
      debugShowCheckedModeBanner: false,

      // Set the theme for the app
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),

      // Set the initial route to LoginPage as the home screen
      home: const LoginPage(),
    );
  }
}
