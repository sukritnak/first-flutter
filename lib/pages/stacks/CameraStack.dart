import 'package:firstFlutter/pages/CameraPage.dart';
import 'package:firstFlutter/pages/PicturePage.dart';
import 'package:flutter/material.dart';

class CameraStack extends StatefulWidget {
  CameraStack({Key key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<CameraStack> {
  @override
  Widget build(BuildContext context) {
      return Navigator(
      initialRoute: 'camerastack/camera',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'camerastack/camera':
            builder = (BuildContext _) => CameraPage();
            break;
          case 'camerastack/picture':
            builder = (BuildContext _) => PicturePage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}