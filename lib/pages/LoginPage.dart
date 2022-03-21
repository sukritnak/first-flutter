import 'package:firstFlutter/redux/appReducer.dart';
import 'package:firstFlutter/redux/profile/profileAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  SharedPreferences prefs;

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  _login(Map<String, dynamic> values) async {
    setState(() {
      isLoading = true;
    });

    var url = 'https://api.codingthailand.com/api/login';
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode({
          'email': values['email'],
          'password': values['password'],
        }));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      // var token = convert.jsonDecode(response.body);
      // print(response.body);
      // save token to prefs
      await prefs.setString('token', response.body);
      //get profile
      await _getProfile();
      // go to home
      Navigator.pushNamedAndRemoveUntil(
          context, '/homestack', (Route<dynamic> route) => false);
    } else {
      setState(() {
        isLoading = false;
      });
      // print(response.body);
      var data = convert.jsonDecode(response.body);
      Flushbar(
        title: '${data['message']}',
        message: 'เกิดข้อผิดพลาด ${data['status_code']}',
        backgroundColor: Colors.redAccent,
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.redAccent[300],
      )..show(context);
    }
  }

  Future<void> _getProfile() async {
    // get token from pref

    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString);

    print(token['access_token']);

    // http to url profile
    var url = 'https://api.codingthailand.com/api/profile';
    var res = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${token['access_token']}'},
    );

    // print('profile ${res.body}');

    var profile = convert.jsonDecode(res.body);
    // save user profile to pref
    await prefs.setString('profile', convert.jsonEncode(profile['data']['user']));


    // call action set redux
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProfileAction(profile['data']['user']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.cyan[100],
              Theme.of(context).accentColor,
            ])),
        child: Center(
            child: SingleChildScrollView(
          child: Column(children: [
            Image(
              image: AssetImage('assets/images/fish-logo.png'),
              height: 90,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: FormBuilder(
                key: _fbKey,
                initialValue: {
                  'email': '',
                  'password': '',
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      name: 'email',
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(color: Colors.red[300]),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        fillColor: Colors.white60,
                      ),
                      // onChanged: _onChanged,
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'ป้อนข้อมูลด้วย'),
                        FormBuilderValidators.email(context,
                            errorText: 'รูปแบบอีเมลล์ไม่ถูก'),
                      ]),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'password',
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(color: Colors.red[300]),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        fillColor: Colors.white60,
                      ),
                      // onChanged: _onChanged,
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'กรุณาป้อนรหัสผ่านด้วย'),
                        FormBuilderValidators.minLength(context, 3,
                            errorText: 'ขั้นต่ำ 3 ตัว'),
                      ]),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        width: 200,
                        child: RaisedButton(
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              // print(_fbKey.currentState.value);
                              _login(_fbKey.currentState.value);
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(20),
                          color: Colors.cyan[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text('ลงทะเบียน',
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration:
                                            TextDecoration.underline)))),
                        Expanded(
                            child: MaterialButton(
                                onPressed: () {},
                                child: Text('ลืมรหัสผ่าน',
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline))))
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        )),
      ),
    );
  }
}
