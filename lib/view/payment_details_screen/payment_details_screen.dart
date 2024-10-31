import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _MyHomeState();
}

class _MyHomeState extends State<PaymentDetailsScreen> {
  late Razorpay _razorpay;
  void _paymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("success$response")));
    //toast
    print("Payment success$response");
  }

  void _paymentFailure(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Paymen fail $response")));
    print("fail$response");
  }

  void _paymentWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Wallet$response")));
    print("wallet$response");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _paymentWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void checkout(
      int amt, num ph, String email, String shopname, String discription) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            checkout(
                100, 9899999999, "sree@gmail.com", "Tshirt", "just a t shirt");
          },
          child: Text("Pay Now"),
        ),
      ),
    );
  }
}
