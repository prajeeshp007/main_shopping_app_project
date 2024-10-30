import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/intermediate_screen/intermediate_Screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
                fit: BoxFit.cover,
                'https://images.pexels.com/photos/5709271/pexels-photo-5709271.jpeg?auto=compress&cs=tinysrgb&w=600'),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Buy Groceries Easily With Us',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Listen Podcast and open your world with this application',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IntermediateScreen(),
                            ));
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(fontSize: 25),
                      ))),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
