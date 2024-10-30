import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:main_shopping_app_project/view/details_screen/details_screen.dart';
import 'package:main_shopping_app_project/view/my_BUcket_screen/my_bucket_screen.dart';

class VegetablesDetailsScreen extends StatefulWidget {
  const VegetablesDetailsScreen({super.key});

  @override
  State<VegetablesDetailsScreen> createState() =>
      _VegetablesDetailsScreenState();
}

class _VegetablesDetailsScreenState extends State<VegetablesDetailsScreen> {
  var vegetablesdetails =
      FirebaseFirestore.instance.collection('vegetablesdetails');
  var addtocart = FirebaseFirestore.instance.collection(' addtocart');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavScreen(),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
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

              /// this is the code to visible the data stored in firestore collection

              StreamBuilder<QuerySnapshot>(
                stream: vegetablesdetails.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 250, // Height of each item
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      image_url: data['image'],
                                      brandname: data['name'],
                                      brandprice: data['price'],
                                      rating: data['rating'],
                                      review: data['review'],
                                      descreption: data['kilogram'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data['image']),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['discount'],
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              data['kilogram'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            Row(
                              children: [
                                Icon(Icons.currency_rupee_rounded,
                                    color: Colors.red),
                                Text(
                                  data['price'],
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              data['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    // Check if the item already exists in the cart
                                    /// this is the code to check the item is already is in the cart or not
                                    var existingItems = await addtocart
                                        .where('name', isEqualTo: data['name'])
                                        .get();

                                    if (existingItems.docs.isEmpty) {
                                      // If the item does not exist, add it to the cart
                                      addtocart.add({
                                        'name': data['name'],
                                        'image': data['image'],
                                        'price': data['price'],
                                        'qty': data['1']
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyBucketScreen(),
                                        ),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text('1 item added to bucket'),
                                        ),
                                      );
                                    } else {
                                      // If the item already exists, show a message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text('Item already in bucket!'),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Add To Bucket',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
