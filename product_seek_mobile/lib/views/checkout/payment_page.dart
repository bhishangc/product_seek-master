import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/views/checkout/confirm_page.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({this.checkoutitems, this.userInfo, this.isFromCart});

  final CheckoutModel checkoutitems;
  final UserModel userInfo;
  final bool isFromCart;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select payment method"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationPage(
                                  checkoutitems: widget.checkoutitems,
                                  paymentType: "card",
                                  isFromCart: widget.isFromCart)));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Credit/Debit Card",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationPage(
                                  checkoutitems: widget.checkoutitems,
                                  paymentType: "paypal",
                                  isFromCart: widget.isFromCart)));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/paypal.svg',
                            height: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Paypal",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: Colors.white,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.checkoutitems.total.toString(),
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
