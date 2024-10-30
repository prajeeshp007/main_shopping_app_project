import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/buy_now_screen/buy_now_Screen.dart';

class MyBucketScreen extends StatefulWidget {
  const MyBucketScreen({super.key});

  @override
  State<MyBucketScreen> createState() => _MyBucketScreenState();
}

class _MyBucketScreenState extends State<MyBucketScreen> {
  var addtocart = FirebaseFirestore.instance.collection(' addtocart');

  /// map to store the quaantity for each items
  Map<String, int> qty = {};

  /// variable to store total amount
  double totalamount = 0;

  @override
  void initState() {
    super.initState();

    /// to update the total amount in ui
    addtocart.snapshots().listen((snapshot) {
      calculateTotalAmount(snapshot);
      setState(() {});
    });
  }

  /// method to calculate total amouunt
  void calculateTotalAmount(QuerySnapshot snapshot) {
    double total = 0;
    for (var doc in snapshot.docs) {
      String docId = doc.id;
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

      String pricestring = data['price'];
      final double unitprice = double.parse(pricestring);
      final int quantity = qty[docId] ?? 1;

      total += unitprice * quantity;
    }
    setState(() {
      totalamount = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Buckets",
          style: TextStyle(),
        ),
      ),
      body: Column(
        children: [
          /// for for showing data to add to cart
          StreamBuilder<QuerySnapshot>(
              stream: addtocart.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          String docId = document.id;

                          // Set initial quantity if not already set
                          qty[docId] ??= 1;

                          /// to calculate the normal price and increasing qty of product price
                          String pricestring = data['price'];

                          /// because in firestore qty is saved as a string in here it is converted in to double using double.parse
                          final double unitprice = double.parse(pricestring);
                          final double totalprice = unitprice * qty[docId]!;

                          /// code for calculate the total price off products in cart

                          return Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(data['image']))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['name'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Rs $totalprice',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: IconButton(
                                            onPressed: () {
                                              if (qty[docId]! > 1) {
                                                qty[docId] = qty[docId]! - 1;
                                                calculateTotalAmount(
                                                    snapshot.data!);
                                                setState(() {});
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                            ))),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${qty[docId]}',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: IconButton(
                                            onPressed: () {
                                              qty[docId] = qty[docId]! + 1;
                                              calculateTotalAmount(
                                                  snapshot.data!);
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            )))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 208, 101, 169),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextButton(
                                          onPressed: () {
                                            //// code for delete products from cart
                                            addtocart.doc(document.id).delete();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        '1 item removed from  bucket')));
                                          },
                                          child: Text(
                                            'Remove from cart',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 208, 101, 169),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BuyNowScreen(
                                                            imageurl:
                                                                data['image'],
                                                            productname:
                                                                data['name'],
                                                            productprice:
                                                                unitprice,
                                                            qty: qty[docId]!)));
                                          },
                                          child: Text(
                                            'Buy this now',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        })
                        .toList()
                        .cast(),
                  ),
                );
              }),

          SizedBox(
            height: 25,
          ),
          ListTile(
            title: Text('Total Price',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            subtitle: Text(
              'RS ${totalamount.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 83, 201, 95),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Place All Orders',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
