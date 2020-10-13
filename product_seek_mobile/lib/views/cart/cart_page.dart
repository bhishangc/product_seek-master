import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/cart_view_model.dart';
import 'package:product_seek_mobile/views/checkout/checkout_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({this.changeIndex});
  final Function(int) changeIndex;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItemModel> cartIems = new List<CartItemModel>();
  bool hasData = false;

  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    cartViewModel.getItemsFromCart().listen((items) {
      if (items.length > 0) {
        setState(() {
          cartIems = items;
          hasData = true;
          totalPrice = 0;
          items.forEach((element) {
            totalPrice += element.totalPrice;
          });
        });
      } else {
        setState(() {
          hasData = false;
          totalPrice = 0;
        });
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildCart(cartViewModel),
              ),
              Visibility(
                visible: hasData,
                child: _buildBottomPage(),
              ),
            ],
          ),
        ));
  }

  Widget _buildBottomPage() {
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
                      text: '\$ ' + totalPrice.toString(),
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
                          builder: (context) => CheckoutPage(
                                checkoutitems: new CheckoutModel(
                                  null,
                                  cartIems,
                                  0,
                                  userDetails.id,
                                ),
                                isFromCart: true,
                              )));
                },
                child: Text(
                  "Checkout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCart(CartViewModel cartViewModel) {
    return Container(
      child: StreamBuilder(
          stream: cartViewModel.getItemsFromCart(),
          builder: (context, AsyncSnapshot<List<CartItemModel>> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data[index];
                    return _buildCartItem(item, cartViewModel);
                  });
            } else {
              return Center(
                child: Text("No Items in cart"),
              );
            }
          }),
    );
  }

  Widget _buildCartItem(CartItemModel item, CartViewModel cartViewModel) {
    ProductModel product = ProductModel.fromLocalJson(jsonDecode(item.product));
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.height / 10,
                  child: FittedBox(
                    child: CachedNetworkImage(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.title),
                          InkWell(
                            onTap: () {
                              promptDeleteMessage(item, cartViewModel);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                onPressed: item.quantity < 2
                                    ? null
                                    : () async {
                                        item.quantity--;
                                        item.totalPrice =
                                            item.quantity * product.price;
                                        await cartViewModel
                                            .changeQuantity(item);
                                      },
                                icon: Icon(
                                  Icons.remove,
                                  size: 20,
                                ),
                              ),
                              Text(item.quantity.toString()),
                              IconButton(
                                onPressed: item.quantity > 4
                                    ? null
                                    : () async {
                                        item.quantity++;
                                        item.totalPrice =
                                            item.quantity * product.price;
                                        await cartViewModel
                                            .changeQuantity(item);
                                      },
                                icon: Icon(
                                  Icons.add,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text('\$ ' + product.price.toString()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  promptDeleteMessage(CartItemModel item, CartViewModel cartViewModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to remove this item from cart?"),
            actions: [
              FlatButton(
                onPressed: () {
                  cartViewModel.removeItemToCart(item);
                  Navigator.pop(context);
                },
                child: Text("Yes"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              ),
            ],
          );
        });
  }
}
