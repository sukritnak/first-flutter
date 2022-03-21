import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  Footer({Key key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String companyName = 'ppla.fs';

  void _changeCompanyName() {
    setState(() {
      companyName = 'welcome';
    });
  }

  @override
  void initState() {
    super.initState();
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //    child: Text('$companyName'),
    // );
    return Column(children: <Widget>[
      Text(
        '$companyName',
        // style: Theme.of(context).textTheme.headline1,
      ),
      RaisedButton(onPressed: _changeCompanyName, child: Text('Click me'))
    ]);
  }
}
