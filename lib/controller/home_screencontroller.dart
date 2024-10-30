import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreencontroller with ChangeNotifier {
  var vegetablescategorycollections =
      FirebaseFirestore.instance.collection(' vegetablescategorycollections');
  void details() {
    vegetablescategorycollections.add({
      'name': "Vegetables",
      'url':
          'https://tse2.mm.bing.net/th?id=OIP.CQBc1tyzQpvMd_T2fZupSwHaE8&pid=Api&P=0&h=180',
      'name': "Fruits",
      'url':
          'https://img.freepik.com/free-photo/vegetable-basket_74190-5178.jpg?ga=GA1.1.1064003731.1721544157&semt=ais_hybrid',
      'name': "Dairy",
      'url':
          'https://img.freepik.com/free-psd/vatrushka-isolated-transparent-background_191095-34584.jpg?size=626&ext=jpg&ga=GA1.1.1064003731.1721544157&semt=ais_hybrid',
      'name': "Meat",
      'url':
          'https://img.freepik.com/premium-psd/raw-meat-isolated-transparent-background_530816-1160.jpg?size=626&ext=jpg&ga=GA1.1.1064003731.1721544157&semt=ais_hybrid',
    });
  }
}
