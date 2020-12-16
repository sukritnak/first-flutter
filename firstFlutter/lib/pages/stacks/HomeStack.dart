import 'package:firstFlutter/pages/AboutPage.dart';
import 'package:firstFlutter/pages/CompanyPage.dart';
import 'package:firstFlutter/pages/ContactPage.dart';
import 'package:firstFlutter/pages/HomePage.dart';
import 'package:firstFlutter/pages/RoomPage.dart';
import 'package:flutter/material.dart';

class HomeStack extends StatefulWidget {
  HomeStack({Key key}) : super(key: key);


  @override
  _HomeStackState createState() => _HomeStackState();
}

class _HomeStackState extends State<HomeStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'homestack/home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'homestack/home':
            builder = (BuildContext _) => HomePage();
            break;
          case 'homestack/about':
            builder = (BuildContext _) => AboutPage();
            break;
          case 'homestack/contact':
            builder = (BuildContext _) => ContactPage();
            break;
          case 'homestack/company':
            builder = (BuildContext _) => CompanyPage();
            break;
          case 'homestack/room':
            builder = (BuildContext _) => RoomPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
