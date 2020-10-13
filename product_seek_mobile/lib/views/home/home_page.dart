import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/viewmodels/product_view_model.dart';
import 'package:product_seek_mobile/views/home/custom_search.dart';
import 'package:product_seek_mobile/views/product/product_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = new List<ProductModel>();

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    productViewModel.getProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Seek"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: FutureBuilder(
                    future: productViewModel.getProducts(),
                    builder:
                        (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                      if (!snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      } else if (snapshot.data.length > 0)
                        return GridView.builder(
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height) /
                                      0.7,
                            ),
                            itemBuilder: (context, index) {
                              var product = snapshot.data[index];
                              return _buildStoreItem(product);
                            });
                      else {
                        return Center(child: Text("No products found"));
                      }
                    }))
          ],
        ),
      ),
    );
  }

  Widget _buildStoreItem(ProductModel product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemDetail(product: product)));
          },
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 4.5,
                child: Hero(
                  tag: product.id,
                  child: CachedNetworkImage(
                    imageUrl: NetworkEndpoints.BASE_URL +
                        jsonDecode(product.images)[0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    product.title,
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
                              text: product.price.toString(),
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
