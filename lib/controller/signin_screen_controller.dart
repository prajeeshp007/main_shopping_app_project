import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/bottom_nav_screen/bottom_nav_screen.dart';

class SigninScreenController with ChangeNotifier {
  bool isloading = false;
  onSignin(
      {required String mail,
      required String psswrd,
      required BuildContext context}) async {
    isloading = true;
    notifyListeners();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: psswrd);
      if (credential.user?.uid != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('user Loggedin Successfully')));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavScreen(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text('invalid credentials')));

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    isloading = false;
    notifyListeners();
  }
}
