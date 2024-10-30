import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MybucketScreenController with ChangeNotifier {
  var addtocart = FirebaseFirestore.instance.collection(' addtocart');
  Map<String, int> qty = {};
  double totalAmount = 0;

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

    totalAmount = total;
    notifyListeners();
  }
}
