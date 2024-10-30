import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/home_screen/home_screen.dart';
import 'package:main_shopping_app_project/view/my_BUcket_screen/my_bucket_screen.dart';
import 'package:main_shopping_app_project/view/myprofle_screen/myprofile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedindex = 0;
  final List<Widget> myscreens = [
    HomeScreen(),
    MyBucketScreen(),
    MyprofileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myscreens[selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'My Buckets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: selectedindex,
        onTap: (index) {
          setState(() {
            selectedindex = index;
          });
        },
        selectedItemColor: Colors.orange.shade800,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
