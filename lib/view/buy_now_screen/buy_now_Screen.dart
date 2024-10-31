import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_shopping_app_project/view/payment_details_screen/payment_details_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BuyNowScreen extends StatefulWidget {
  final String imageurl;
  final String productname;
  final double productprice;
  final int qty;
  const BuyNowScreen(
      {super.key,
      required this.imageurl,
      required this.productname,
      required this.productprice,
      required this.qty});

  @override
  State<BuyNowScreen> createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  final editProfile = FirebaseFirestore.instance.collection('editprofile');
  String? name;
  String? phone;
  String? address;
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _paymentWallet);
  }

  @override
  Future<void> _loadUserProfile() async {
    final snapshot = await editProfile
        .doc('USER_ID')
        .get(); // Replace 'USER_ID' with actual user ID
    if (snapshot.exists) {
      final data = snapshot.data()!;
      setState(() {
        name = data['name'];
        phone = data['phone'];
        address =
            data['address']; // Assuming the image URL is stored in 'imageUrl'
      });
    }
  }

  late Razorpay _razorpay;
  void _paymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("success$response")));
    //toast
    print("Payment success$response");
  }

  void _paymentFailure(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red, content: Text("Paymen fail $response")));
    print("fail$response");
  }

  void _paymentWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Wallet$response")));
    print("wallet$response");
  }

  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void checkout(double amt, String ph, String email, String shopname,
      String discription) {
    var options = {
      //dynamic key of clint please replace key with ur key
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      //amt in pisa
      'amount': amt * 100,
      'name': shopname,
      'description': discription,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '$ph', 'email': '$email'},
      'external': {
        'wallets': ['paytm', 'gpay']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    ///  code for calculating total amount
    double totalAmount = widget.productprice * widget.qty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Order Summary'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deliver to:',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(
                name ?? 'name not avilable',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(
                address ?? 'address not available',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Text(
                phone ?? 'number not available',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: ListTile(
            leading: Image(height: 60, image: NetworkImage(widget.imageurl)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productname,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'RS ${widget.productprice.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            subtitle: Text(
              'delivered by today',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            trailing: Text(
              'Qty ${widget.qty}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Note: Gst and No Cost EMI will not be applicable',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Price Details',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Row(
                children: [
                  Icon(Icons.currency_rupee_sharp),
                  Text(
                    widget.productprice.toStringAsFixed(2),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Row(
                children: [
                  Icon(Icons.remove),
                  Text(
                    '20%',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Charges',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Row(
                children: [
                  Icon(Icons.delivery_dining_outlined),
                  Text(
                    'Free Delivery',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'RS ${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                    onPressed: () {
                      // Add your payment logic here
                      checkout(totalAmount, phone!, 'prajeeshpramod@gmail.com',
                          "Akshatam Mart", "Grocery Item");
                    },
                    child: Text(
                      'Pay Now',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        )
      ]),
    );
  }
}
