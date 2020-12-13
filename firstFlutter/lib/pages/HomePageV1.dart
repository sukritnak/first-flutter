import 'package:firstFlutter/widgets/logo.dart';
import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;
  var fromAbout;
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Map pushBack = ModalRoute.of(context).settings.arguments ?? {'text': 'สวัสดี'};
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        centerTitle: true,
        // title: Logo(), // ถ้าเราใส่แบบนี้ มันจะ build โลโก้ทุกรอบเปลือง performance
        title:
            const Logo(), // ถ้าใส่ const จะไม่ให้ rebuild ซ้ำ ในการ set State class นี้
      ),
      drawer: Menu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Logo(),
            Text(
              'Pla - Sukrit',
            ),
            // Text('from about page is ${fromAbout ?? ''}'),
            Text('from about page is ${fromAbout ?? pushBack['text'] ?? ''}'),
            RaisedButton(
                child: Text('เกี่ยวกับเรา'),
                onPressed: () async {
                  // fromAbout = await Navigator.pushNamed(context, '/about',
                  fromAbout = await Navigator.pushNamed(
                      context, 'homestack/about', arguments: <String, dynamic>{
                    'email': 'sukrit.nak@gmail.com',
                    'phone': '0868888'
                  });

                  setState(() {
                    fromAbout = fromAbout['text'];
                  });
                })
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline1,
            // ),
            // Footer(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
