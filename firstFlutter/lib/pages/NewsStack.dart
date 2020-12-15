import 'package:firstFlutter/pages/DetailPage.dart';
import 'package:firstFlutter/pages/NewsPage.dart';
import 'package:firstFlutter/pages/ProductPage.dart';
import 'package:firstFlutter/pages/WebViewPage.dart';
import 'package:flutter/material.dart';

class NewsStack extends StatefulWidget {
  NewsStack({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsStack> {
  @override
  Widget build(BuildContext context) {
      return Navigator(
      initialRoute: 'newsstack/news',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'newsstack/news':
            builder = (BuildContext _) => NewsPage();
            break;
          case 'newsstack/webviews':
            builder = (BuildContext _) => WebViewPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}