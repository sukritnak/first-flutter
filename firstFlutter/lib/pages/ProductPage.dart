import 'package:firstFlutter/widgets/logo.dart';
import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('สินค้า'),
      ),
      drawer: Menu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Logo(),
            Text(
              'สินค้า',
            ), 
          ],
        ),
      ),
    );
  }
}
