import 'package:firstFlutter/pages/stacks/HomeStack.dart';
import 'package:firstFlutter/pages/stacks/NewsStack.dart';
import 'package:firstFlutter/pages/stacks/ProductStack.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter pla Demo',
      theme: ThemeData(
          // primarySwatch: Colors.brown,
          primaryColor: Colors.cyan[600],
          accentColor: Colors.cyan[300],
          // canvasColor: Colors.cyanAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 50, color: Colors.cyan[600]))),
      // home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeStack(),
        '/productstack': (context) => ProductStack(),
        '/newsstack': (context) => NewsStack(),
      },
      // routes: <String, WidgetBuilder>{
      //   '/': (context) => HomePage(),
      //   '/about': (context) => AboutPage(),
      //   '/contact': (context) => ContactPage(),
      // },
    );
  }
}
