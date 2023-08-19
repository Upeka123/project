import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/home_page.dart';
import 'package:project/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //Create a reactive variable to hold the current user

    // Bind the _user variable to the Firebase Authentication userChanges() stream
    // This will keep the _user variable in sync with the user authentication state
    _user.bindStream(auth.userChanges());

    // Use ever() to react to changes in the _user variable and execute _initialScreen()
    ever(_user, _initialScreen);
  }

  // This function is executed whenever the user authentication state changes
  _initialScreen(User? user) {
    // If the user is not logged in (null), navigate to the login page
    // Otherwise, navigate to the home page with the user's email as a parameter
    if (user == null) {
      print("login page");
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => HomePage(email: user.email!));
    }
  }

  // Function to register a new user with the provided email and password
  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Show a snackbar with an error message if account creation fails
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  // Function to log in the user with the provided email and password
  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Show a snackbar with an error message if login fails
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  // Function to log out the currently logged-in user
  void logOut() async {
    await auth.signOut();
  }
}
