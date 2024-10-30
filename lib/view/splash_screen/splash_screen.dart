import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/utils/image_constance.dart';
import 'package:main_shopping_app_project/view/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScfreeState();
}

class _SplashScfreeState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then(
      (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(240, 250, 110, 3),
      body: Center(child: Image.asset(ImageConstance.splashimage3)),
    );
  }
}
