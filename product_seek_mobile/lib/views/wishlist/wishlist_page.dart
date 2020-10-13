import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/models/wish_list_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/viewmodels/wishlist_view_model.dart';
import 'package:product_seek_mobile/views/product/product_details.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({this.userInfo});

  UserModel userInfo;

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    WishlistViewModel wishlistViewModel =
        Provider.of<WishlistViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: wishlistViewModel.getWishlist(widget.userInfo.id),
                  builder:
                      (context, AsyncSnapshot<List<WishlistModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    } else if (snapshot.data.length > 0) {
                      return GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height) /
                                    0.68,
                          ),
                          itemBuilder: (context, index) {
                            var product = snapshot.data[index];
                            return _buildWishlistItem(product);
                          });
                    } else {
                      print("Data Length of snapshot" +
                          snapshot.data.length.toString());
                      return Center(child: Text("No favourites"));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistItem(WishlistModel wishlist) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ItemDetail(product: wishlist.product)));
          },
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 4.5,
                child: Hero(
                  tag: wishlist.product.id,
                  child: CachedNetworkImage(
                    imageUrl: NetworkEndpoints.BASE_URL +
                        jsonDecode(wishlist.product.images)[0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    wishlist.product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: RichText(
                        text: TextSpan(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            children: <TextSpan>[
                          TextSpan(text: '\$ '),
                          TextSpan(
                              text: wishlist.product.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
