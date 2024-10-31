import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_shopping_app_project/view/bottom_nav_screen/bottom_nav_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final editprofile = FirebaseFirestore.instance.collection('editprofile');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? url;

  final ImagePicker picker = ImagePicker();
  XFile? imagefile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// code for save the edit profile data  in the text form field
  Future<void> _loadUserData() async {
    // Retrieve user data from Firestore
    final snapshot = await editprofile
        .doc('USER_ID')
        .get(); // Replace 'USER_ID' with actual user ID

    /// code for adding data to firebase
    if (snapshot.exists) {
      final data = snapshot.data()!;
      nameController.text = data['name'] ?? '';
      phoneController.text = data['phone'] ?? '';
      address.text = data['address'] ?? '';
      url = data['url'];
      setState(() {}); // Update the UI with the retrieved data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (imagefile != null) {
                              final storageRef = FirebaseStorage.instance
                                  .ref(); // create reference

                              Reference? folderRef = storageRef.child(
                                  "images/${imagefile!.name}"); // create for folder reference

                              final imageRef =
                                  folderRef.child('profiledetails.jpg');

                              /// create for save in a name

                              await imageRef.putFile(File(imagefile!.path));

                              /// for uploading the file

                              url = await imageRef
                                  .getDownloadURL(); // fro downloading url
                            }

                            imagefile = await picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                imagefile != null ? NetworkImage(url!) : null,
                            radius: 60,
                            child: url == null
                                ? Icon(Icons.camera_alt, size: 40)
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Edit Profile Picture",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name ',
                    )),
                SizedBox(height: 20),
                TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Phone number ',
                    )),
                SizedBox(height: 20),
                TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Address ',
                    )),
                SizedBox(height: 200),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please enter your name')));
                          return;
                        }
                        if (phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please enter your phone number')));
                          return;
                        }

                        // Update Firestore document and showwing in the fields
                        if (_formKey.currentState!.validate()) {
                          editprofile.doc('USER_ID').set({
                            'name': nameController.text,
                            'phone': phoneController.text,
                            'address': address.text,
                            'url': url
                          });
                        }

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Profile Updated')));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavScreen(),
                            ));
                      },
                      child: Text(
                        'Submit Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
