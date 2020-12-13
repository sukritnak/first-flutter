import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Text('Logo', style: TextStyle(fontSize: 30)),
    // );
    // return FlutterLogo(size: 60);
    print('build logo');
    return Image.asset('assets/images/fish-logo.png', height: 50, fit: BoxFit.cover);
  }
}
