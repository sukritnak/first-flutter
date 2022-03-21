import 'package:firstFlutter/redux/appReducer.dart';
import 'package:firstFlutter/redux/profile/profileAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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

  _updateProfile(Map<String, dynamic> values) async {
    setState(() {
      isLoading = true;
    });

    // get token
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString);

    var url = 'https://api.codingthailand.com/api/editprofile';
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token['access_token']}'
        },
        body: convert.jsonEncode({
          'name': values['name'],
        }));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      //get profile
      var pf = response.body;
      await _saveProfile(pf);
      // go to home
      Navigator.pushNamedAndRemoveUntil(
          context, 'homestack/home', (Route<dynamic> route) => false);
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

  Future<void> _saveProfile(String pf) async {
    var profileUpdate = convert.jsonDecode(pf);
    await prefs.setString(
        'profile', convert.jsonEncode(profileUpdate['data']['user']));

    // call action set redux
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProfileAction(profileUpdate['data']['user']));
  }

  @override
  Widget build(BuildContext context) {
    Map user = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('แก้ไขข้อมูลส่วนตัว')),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 50, 15, 10),
              child: FormBuilder(
                key: _fbKey,
                initialValue: {
                  'name': '${user['name']}',
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      name: 'name',
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'ชื่อ-สกุล',
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
                            errorText: 'ป้อนข้อมูล ชื่อ-สกุล ด้วย'),
                      ]),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        width: 200,
                        child: RaisedButton(
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              // print(_fbKey.currentState.value);
                              _updateProfile(_fbKey.currentState.value);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('แก้ไข',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              isLoading == true
                                  ? CircularProgressIndicator()
                                  : Text(''),
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          color: Colors.cyan[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
