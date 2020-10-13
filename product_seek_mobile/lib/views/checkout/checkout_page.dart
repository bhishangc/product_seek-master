import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/views/checkout/payment_page.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({this.checkoutitems, this.isFromCart});

  final CheckoutModel checkoutitems;
  final bool isFromCart;

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double subTotal = 0;

  double shippingFee = 5;

  UserModel userInfo;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (userDetails != null) userInfo = userDetails;
      shippingFee = shippingFee * widget.checkoutitems.prductList.length;
      widget.checkoutitems.prductList.forEach((item) {
        ProductModel product =
            ProductModel.fromLocalJson(jsonDecode(item.product));
        subTotal = subTotal + (product.price * item.quantity);
      });
      widget.checkoutitems.total = subTotal + shippingFee;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              userInfo.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                              child: Text(
                                "EDIT",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).accentColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      _buildBillingAddress(),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ]),
                  ),
                  _buildCheckOutItems(),
                  _buildSubtotalMenu(),
                ],
              ),
            )),
            _buildBottomControl(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtotalMenu() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal (" +
                      widget.checkoutitems.prductList.length.toString() +
                      " Items)"),
                  Text('\$ ' + subTotal.toString())
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Shipping fee"),
                  Text('\$ ' + shippingFee.toString())
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildCheckOutItems() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        var productItem = widget.checkoutitems.prductList[index];
        return _buildItems(productItem, index);
      }, childCount: widget.checkoutitems.prductList.length),
    );
  }

  Widget _buildItems(CartItemModel item, int index) {
    ProductModel product = ProductModel.fromLocalJson(jsonDecode(item.product));
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Package " +
                (index + 1).toString() +
                " of " +
                widget.checkoutitems.prductList.length.toString()),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.height / 10,
                  child: FittedBox(
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height / 10,
                      imageUrl: NetworkEndpoints.BASE_URL +
                          jsonDecode(product.images)[0],
                    ),
                    fit: BoxFit.fill,
                  )),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(product.title),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('\$ ' + product.price.toString()),
                            Text("Qty. " + item.quantity.toString())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Item(s) total: ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: '\$ ' + item.totalPrice.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBillingAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 20,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    userInfo.address,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.phone,
                size: 20,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    userInfo.phoneNumber,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                size: 20,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    userInfo.email,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControl() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Theme.of(context).accentColor),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Total: ',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  TextSpan(
                      text: '\$ ' + widget.checkoutitems.total.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ])),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 45,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentPage(
                              checkoutitems: widget.checkoutitems,
                              userInfo: userInfo,
                              isFromCart: widget.isFromCart)));
                },
                child: Text(
                  "Proceed to Pay",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
