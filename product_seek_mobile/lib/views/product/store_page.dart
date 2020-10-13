import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/models/store_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/store_view_model.dart';
import 'package:product_seek_mobile/views/home/custom_search.dart';
import 'package:product_seek_mobile/views/login/login_page.dart';
import 'package:product_seek_mobile/views/product/product_details.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  StorePage({this.storeInfo});

  final StoreModel storeInfo;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool _isFollowed = false;
  String _followButtonText = "Follow";
  String _followers = "0";
  StoreViewModel storeViewModel;
  StoreModel storeInfo;

  toggleFollow() {
    setState(() {
      _isFollowed = !_isFollowed;
      if (_isFollowed) {
        storeViewModel
            .followStore(userDetails.id, storeInfo.id)
            .then((value) => fetchStroeInfo());
        _followButtonText = "Following";
      } else {
        _followButtonText = "Follow";
        storeViewModel
            .unfollowStore(userDetails.id, storeInfo.id)
            .then((value) => fetchStroeInfo());
      }
    });
  }

  fetchStroeInfo() {
    storeViewModel.getStoreInfo(widget.storeInfo.id).then((store) {
      if (store != null) {
        setState(() {
          storeInfo = store;
          setState(() {
            _followers = jsonDecode(storeInfo.followers).length.toString();
          });
          jsonDecode(storeInfo.followers).forEach((item) {
            if (item == userDetails.id.toString()) {
              if (!_isFollowed)
                setState(() {
                  _isFollowed = true;
                  _followButtonText = "Following";
                });
            }
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    storeViewModel = Provider.of<StoreViewModel>(context, listen: false);
    fetchStroeInfo();
  }

  @override
  Widget build(BuildContext context) {
    final storeViewModel = Provider.of<StoreViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Information"),
        actions: [
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
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: CachedNetworkImage(
                      imageUrl: "https://picsum.photos/600",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.storeInfo.name,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.storeInfo.address,
                              )),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _followers + " Followers",
                            )),
                      ],
                    ),
                  )),
                  OutlineButton(
                    onPressed: () {
                      if (globalIsLoggedIn) {
                        toggleFollow();
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                    child: Text(
                      _followButtonText,
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: <Widget>[
              Expanded(flex: 1, child: Divider()),
              Text("PRODUCTS"),
              Expanded(flex: 20, child: Divider()),
            ]),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              child: FutureBuilder(
                  future: storeViewModel.getStoreItems(widget.storeInfo.id),
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
                            return _buildStoreItem(product);
                          });
                    } else {
                      return Center(child: Text("No products found"));
                    }
                  }),
            )),
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
