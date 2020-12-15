import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

// try to use Future builder
class _AboutPageState extends State<AboutPage> {
  Future<Map<String, dynamic>> _getData() async {
    var url = 'https://api.codingthailand.com/api/version';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> version = convert.jsonDecode(response.body);
      return version;
    } else {
      throw Exception('Fail to load version ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
  }

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
              FutureBuilder<Map<String, dynamic>>(
                future: _getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data['data']['version']);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
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
