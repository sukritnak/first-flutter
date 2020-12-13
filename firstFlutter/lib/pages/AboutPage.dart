import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    Map company = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('เกี่ยวกับเรา'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('ปลา'),
              SizedBox(height: 20),
              Text('Email: ${company['email']}'),
              Divider(height: 20),
              Text('Tel: ${company['phone']}'),
              RaisedButton(
                  child: Text('กลับหน้าหลัก'),
                  onPressed: () {
                    Navigator.pop(context, {'text': 'ขอต้อนรับกลับมา'});
                  }),
              RaisedButton(
                  child: Text('ติดต่อเรา'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/contact');
                    Navigator.pushNamed(context, 'homestack/contact');
                  })
            ]),
      ),
    );
  }
}
