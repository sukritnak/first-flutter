import 'package:firstFlutter/redux/appReducer.dart';
import 'package:firstFlutter/redux/profile/profileReducer.dart';
import 'package:firstFlutter/widgets/logo.dart';
import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');

    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Map pushBack = ModalRoute.of(context).settings.arguments ?? {'text': ''};
    return Scaffold(
        appBar: AppBar(
          // title: Text(widget.title),
          centerTitle: true,
          // title: Logo(), // ถ้าเราใส่แบบนี้ มันจะ build โลโก้ทุกรอบเปลือง performance
          title:
              const Logo(), // ถ้าใส่ const จะไม่ให้ rebuild ซ้ำ ในการ set State class นี้
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _logout();
              },
            )
          ],
        ),
        drawer: Menu(),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg-blue.png'),
                    fit: BoxFit.cover)),
            child: Column(children: [
              StoreConnector<AppState, ProfileState>(
                  // เผื่ออนาคต profileState มีอย่างอื่น นอกจาก profile
                  // StoreConnector<AppState, Map<String, dynamic>>(
                  distinct:
                      true, // distinct ถ้าเป็นค่าเดิมจะไม่ดึง ต้องไป implement [==] [hashcode] เพิ่ม
                  // ในที่นี้จะลง lib [equatable]
                  builder: (context, profileState) {
                    // builder: (context, profile) {
                    return Expanded(
                      flex: 1,
                      child: Center(
                          child: Text(
                              'Welcome ${profileState.profile['name']} Email: ${profileState.profile['email']}')),
                      // 'Welcome ${profile['name']} Email: ${profile['email']}')),
                    );
                  },
                  // เผื่ออนาคต profileState มีอย่างอื่น นอกจาก profile
                  converter: (store) => store.state.profileState),
              // converter: (store) => store.state.profileState.profile),
              Expanded(
                  flex: 8,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'homestack/company');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.business,
                                  size: 50,
                                  color: Colors.cyan[700],
                                ),
                                Text('บริษัท', style: TextStyle(fontSize: 20))
                              ],
                            ),
                            color: Colors.white70,
                          )),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.map,
                              size: 50,
                              color: Colors.cyan[700],
                            ),
                            Text('แผนที่', style: TextStyle(fontSize: 20))
                          ],
                        ),
                        color: Colors.white70,
                      ),
                      GestureDetector(
                          onTap: () async {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed('/camerastack');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.cyan[700],
                                ),
                                Text('กล้อง', style: TextStyle(fontSize: 20))
                              ],
                            ),
                            color: Colors.white70,
                          )),
                      GestureDetector(
                        onTap: () async {
                          // fromAbout = await Navigator.pushNamed(context, '/about',
                          fromAbout = await Navigator.pushNamed(
                              context, 'homestack/about',
                              arguments: <String, dynamic>{
                                'email': 'sukrit.nak@gmail.com',
                                'phone': '0868888'
                              });

                          setState(() {
                            fromAbout = fromAbout['text'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.cyan[700],
                              ),
                              Text(
                                  'เกี่ยวกับ ${fromAbout ?? pushBack['text'] ?? ''}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // fromAbout = await Navigator.pushNamed(context, '/about',
                          fromAbout = await Navigator.pushNamed(
                              context, 'homestack/room');

                          setState(() {
                            fromAbout = fromAbout['text'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.room_service_outlined,
                                size: 50,
                                color: Colors.cyan[700],
                              ),
                              Text('ห้องพัก',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // เขียนอีกถ้าเพราะตอนนี้เราอยู่ใน Homestack ต้องไปที่ root
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed('/customer');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.group,
                                size: 50,
                                color: Colors.cyan[700],
                              ),
                              Text('ลูกค้า',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ))
            ])));
  }
}
