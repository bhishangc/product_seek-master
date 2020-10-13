import 'package:flutter/material.dart';
import 'package:product_seek_mobile/views/root_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Initializes theme of the app
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffFF420E),
        accentColor: Color(0xffF98866),
      ),
      title: 'Product Seek',
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}
