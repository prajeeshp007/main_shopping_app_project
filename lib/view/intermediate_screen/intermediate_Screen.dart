import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:main_shopping_app_project/view/sign_in_screen/sign_in_screen.dart';

class IntermediateScreen extends StatefulWidget {
  const IntermediateScreen({super.key});

  @override
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavScreen();
        } else {
          return signinscreen();
        }
      },
    );
  }
}
