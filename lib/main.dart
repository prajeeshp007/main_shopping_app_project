import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/controller/registration_screen_controller.dart';
import 'package:main_shopping_app_project/controller/signin_screen_controller.dart';
import 'package:main_shopping_app_project/firebase_options.dart';
import 'package:main_shopping_app_project/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SigninScreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
