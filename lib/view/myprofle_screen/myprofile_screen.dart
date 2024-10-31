import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/edit_profile_screen/edit_profile_screen.dart';
import 'package:main_shopping_app_project/view/sign_in_screen/sign_in_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final editProfile = FirebaseFirestore.instance.collection('editprofile');
  String? name;
  String? phone;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  /// code for showing the saved name phone number and url in the ui
  Future<void> _loadUserProfile() async {
    final snapshot = await editProfile
        .doc('USER_ID')
        .get(); // Replace 'USER_ID' with actual user ID
    if (snapshot.exists) {
      final data = snapshot.data()!;
      setState(() {
        name = data['name'];
        phone = data['phone'];
        imageUrl =
            data['url']; // Assuming the image URL is stored in 'imageUrl'
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Display Container
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : AssetImage('assets/default_profile.png')
                            as ImageProvider,
                    radius: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name ?? 'Name not available',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phone ?? 'Phone number not available',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            // Other Menu Options
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.home_filled)),
                const Text(
                  'Home',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ));
                    },
                    icon: Icon(Icons.person_4)),
                const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.notifications_active)),
                const Text(
                  'Notifications',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.currency_rupee_rounded)),
                const Text(
                  'Money',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => signinscreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.logout_outlined)),
                const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
