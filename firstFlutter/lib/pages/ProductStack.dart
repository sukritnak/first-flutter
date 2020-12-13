import 'package:firstFlutter/pages/DetailPage.dart';
import 'package:firstFlutter/pages/ProductPage.dart';
import 'package:flutter/material.dart';

class ProductStack extends StatefulWidget {
  ProductStack({Key key}) : super(key: key);

  @override
  _ProductStackState createState() => _ProductStackState();
}

class _ProductStackState extends State<ProductStack> {
  @override
  Widget build(BuildContext context) {
      return Navigator(
      initialRoute: 'productstack/product',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'productstack/product':
            builder = (BuildContext _) => ProductPage();
            break;
          case 'productstack/detail':
            builder = (BuildContext _) => DetailPage();
            break;
          case 'productstack/contact':
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}