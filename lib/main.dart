import 'package:firstFlutter/pages/BarcodePage.dart';
import 'package:firstFlutter/pages/CustomerPage.dart';
import 'package:firstFlutter/pages/LoginPage.dart';
import 'package:firstFlutter/pages/MapPage.dart';
import 'package:firstFlutter/pages/RegisterPage.dart';
import 'package:firstFlutter/pages/stacks/CameraStack.dart';
import 'package:firstFlutter/pages/stacks/HomeStack.dart';
import 'package:firstFlutter/pages/stacks/NewsStack.dart';
import 'package:firstFlutter/pages/stacks/ProductStack.dart';
import 'package:firstFlutter/redux/appReducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

String token;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//// config
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("e48a027a-98a8-4abe-a145-d0274e3b2571", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
//// config

  OneSignal.shared
      .setNotificationReceivedHandler((OSNotification notification) {
    // will be called whenever a notification is received
    print('noti from server' + notification.jsonRepresentation());
    print('noti from server' + notification.payload.body);
    print('noti from server' + notification.payload.title);
  });

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // will be called whenever a notification is opened/button pressed.
    print('result');
    // เปิดหน้าข่าว ที่ ส่งมาจาก OneSignal
    print(result.notification.payload.additionalData['page']);
    // ปกติเราเขียนแบบนี้ แต่อันนี้เราไม่มี context ใช้ที่นี่ไม่ได้เลยต้องไปใช้ global key
    // Navigator.pushNamed(context, routeName)


    navigatorKey.currentState.pushNamed(result.notification.payload.additionalData['page']);

  });

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
          navigatorKey: navigatorKey,
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
            '/camerastack': (context) => CameraStack(),
            '/barcode': (context) => BarcodePage(),
            '/map': (context) => MapPage(),
          },
          // routes: <String, WidgetBuilder>{
          //   '/': (context) => HomePage(),
          //   '/about': (context) => AboutPage(),
          //   '/contact': (context) => ContactPage(),
          // },
        ));
  }
}
