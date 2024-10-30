import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/dummydb.dart';

import 'package:main_shopping_app_project/view/vegetables%20details/vegetables_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var vegetablesdetails =
      FirebaseFirestore.instance.collection('vegetablesdetails');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Replace with profile image URL
            ),
            SizedBox(width: 10),
            Text(
              'Hi, Prajeesh p',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Spacer(),
            Icon(Icons.notifications, color: Colors.black),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                        ),
                      ),
                    ),
                    Icon(Icons.mic, color: Colors.orange.shade800),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Categories Section
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                    mainAxisExtent: 200),
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VegetablesDetailsScreen(),
                          ));
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    Dummydb.buildCategoryItem[index]['url'])),
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          height: 150,
                          width: 200,
                        ),
                        Text(
                          Dummydb.buildCategoryItem[index]['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    )),
              ),
              SizedBox(height: 20),

              // Promotional Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Image.network(
                      'https://via.placeholder.com/150', // Replace with image URL
                      width: 80,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Up to 30% offer!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Enjoy our big offer of every day',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Shop Now'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Popular Items Section
              // Text(
              //   'Popular',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 18,
              //   ),
              // ),
              // SizedBox(height: 10),
              // Row(
              //   children: [
              //     _buildPopularItem('Strawberry', '30min', '4.5', '8.99'),
              //     SizedBox(width: 16),
              //     _buildPopularItem('Tomato', '25min', '4.3', '4.99'),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(var name, var url) {
    return Column(
      children: [
        Container(
          height: 130,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url)),
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
