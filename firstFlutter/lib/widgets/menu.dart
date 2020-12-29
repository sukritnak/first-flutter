import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Map<String, dynamic> profile = {'email': '', 'name': '', 'role': ''};

  _getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // DrawerHeader(
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //   ),
              //   child: Text(
              //     'เมนูหลัก',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 24,
              //     ),
              //   ),
              // ),
              // mock picture
              UserAccountsDrawerHeader(
                accountName: Text('${profile['name']}'),
                accountEmail:
                    Text('${profile['email']} role: ${profile['role']} '),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/fish.jpg')),
                otherAccountsPictures: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, 'homestack/editprofile',
                            arguments: {'name': profile['name']});
                      })
                ],
              ),

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
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ));
  }
}
