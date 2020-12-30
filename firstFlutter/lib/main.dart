import 'package:firstFlutter/pages/CustomerPage.dart';
import 'package:firstFlutter/pages/LoginPage.dart';
import 'package:firstFlutter/pages/RegisterPage.dart';
import 'package:firstFlutter/pages/stacks/HomeStack.dart';
import 'package:firstFlutter/pages/stacks/NewsStack.dart';
import 'package:firstFlutter/pages/stacks/ProductStack.dart';
import 'package:firstFlutter/redux/appReducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

String token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
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
            // '/': (context) => HomeStack(),
            '/': (context) => token == null ? LoginPage() : HomeStack(),
            // '/': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/login': (context) => LoginPage(),
            '/homestack': (context) => HomeStack(),
            '/productstack': (context) => ProductStack(),
            '/newsstack': (context) => NewsStack(),
            '/customer': (context) => CustomerPage(),
          },
          // routes: <String, WidgetBuilder>{
          //   '/': (context) => HomePage(),
          //   '/about': (context) => AboutPage(),
          //   '/contact': (context) => ContactPage(),
          // },
        ));
  }
}
