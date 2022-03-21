import 'package:firstFlutter/redux/appReducer.dart';
// import 'package:firstFlutter/redux/profile/profileAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert' as convert;
// import 'dart:convert' as convert;

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // เปลี่ยนไปใช้ state
  // Map<String, dynamic> profile = {'email': '', 'name': '', 'role': ''};

// ไปทำที่ home
  // _getProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var profileString = prefs.getString('profile');
  //   if (profileString != null) {
  //     // เปลี่ยนไปใช้ state
  //     // setState(() {
  //     //   profile = convert.jsonDecode(profileString);
  //     // });

  //     // เรียก action
  //     // call action set redux
  //     final store = StoreProvider.of<AppState>(context);
  //     store.dispatch(getProfileAction(convert.jsonDecode(profileString)));
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // _getProfile();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // mock picture
              StoreConnector<AppState, Map<String, dynamic>>(
                  distinct:
                      true, // distinct ถ้าเป็นค่าเดิมจะไม่ดึง ต้องไป implement [==] [hashcode] เพิ่ม
                  // ในที่นี้จะลง lib [equatable]
                  builder: (context, profile) {
                    return UserAccountsDrawerHeader(
                      accountName: Text('${profile['name']}'),
                      accountEmail:
                          Text('${profile['email']} role: ${profile['role']} '),
                      currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/fish.jpg')),
                      otherAccountsPictures: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, 'homestack/editprofile',
                                  arguments: {'name': profile['name']});
                            })
                      ],
                    );
                  },
                  converter: (store) => store.state.profileState.profile),

              ListTile(
                leading: Icon(Icons.home),
                title: Text('หน้าหลัก'),
                trailing: Icon(Icons.arrow_right),
                selected:
                    ModalRoute.of(context).settings.name == 'homestack/home'
                        ? true
                        : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/homestack', (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.all_out),
                title: Text('สินค้า'),
                selected: ModalRoute.of(context).settings.name ==
                        'productstack/product'
                    ? true
                    : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/productstack', (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.article),
                title: Text('ข่าวสาร'),
                selected:
                    ModalRoute.of(context).settings.name == 'newsstack/news'
                        ? true
                        : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/newsstack', (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.qr_code),
                title: Text('Barcode/QRCode'),
                selected: ModalRoute.of(context).settings.name == '/barcode'
                    ? true
                    : false,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                          '/barcode', (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ));
  }
}
