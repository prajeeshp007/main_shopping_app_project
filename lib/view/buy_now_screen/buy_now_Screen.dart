import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    ///  code for calculating total amount
    double totalAmount = widget.productprice * widget.qty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Payment Details'),
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
                'Prajeesh ',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Text(
                'praveena Nivas Kinavallur Parli Post Paalakkad',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Text(
                '9074230961',
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
                    'RS${totalAmount.toStringAsFixed(2)}',
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
                    onPressed: () {},
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
