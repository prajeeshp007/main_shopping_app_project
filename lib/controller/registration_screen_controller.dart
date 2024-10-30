import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/sign_in_screen/sign_in_screen.dart';

class RegistrationScreenController with ChangeNotifier {
  bool isloading = false;
  onRegistration(
      {required String password,
      required String email,
      required BuildContext context}) async {
    isloading = true;
    notifyListeners();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user?.uid != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('User registered sucessfully')));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => signinscreen(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }
}
