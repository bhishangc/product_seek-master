import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/order_model.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/order_view_model.dart';
import 'package:product_seek_mobile/views/order/order_detail.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({Key key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Items"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: orderViewModel.getDeliveredOrders(userDetails.id),
                builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
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
                          return _buildOrderItem(item, context);
                        });
                  } else {
                    print("Data Length of snapshot" +
                        snapshot.data.length.toString());
                    return Center(child: Text("No Orders"));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderModel item, BuildContext context) {
    ProductModel product = item.product;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetail(
                      orderItem: item,
                    )));
      },
      child: Container(
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
                        Text(item.orderNumber, style: TextStyle(fontSize: 16)),
                        Text(
                          product.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            item.status.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("Quantity: " + item.quantity.toString()),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("\$ " + (item.totalPrice + 5).toString()),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
