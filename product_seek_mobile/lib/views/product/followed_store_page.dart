import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/store_model.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/store_view_model.dart';
import 'package:product_seek_mobile/views/product/store_page.dart';
import 'package:provider/provider.dart';

class FollowedStorePage extends StatefulWidget {
  FollowedStorePage({Key key}) : super(key: key);

  @override
  _FollowedStorePageState createState() => _FollowedStorePageState();
}

class _FollowedStorePageState extends State<FollowedStorePage> {
  @override
  Widget build(BuildContext context) {
    final storeViewModel = Provider.of<StoreViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Followed Store"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: storeViewModel.getFollowedStore(userDetails.id),
                builder: (context, AsyncSnapshot<List<StoreModel>> snapshot) {
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
                          return _buildStoreItem(item, context);
                        });
                  } else {
                    return Center(child: Text("No Followed Stores"));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildStoreItem(StoreModel store, BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StorePage(
                                storeInfo: store,
                              )));
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.store,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          store.name,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(store.address)
                      ],
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
