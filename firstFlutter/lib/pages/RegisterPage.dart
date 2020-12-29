import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  _register(Map<String, dynamic> values) async {
    setState(() {
      isLoading = true;
    });

    var url = 'https://api.codingthailand.com/api/register';
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode({
          'name': values['name'],
          'email': values['email'],
          'password': values['password'],
          'dob': values['dob'].toString().substring(0, 10),
        }));

    if (response.statusCode == 201) {
      setState(() {
        isLoading = false;
      });
      var data = convert.jsonDecode(response.body);
      Flushbar(
        title: '${data['message']}',
        message: "สามารถล๊อคอินได้ทันที",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      )..show(context);

      // back pop login
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // print(response.body);
      var data = convert.jsonDecode(response.body);
      Flushbar(
        title: '${data['message']}',
        message: '${data['errors']['email'][0]}',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียน'),
        centerTitle: false,
        // automaticallyImplyLeading: false,
      ),
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
            Padding(
              padding: EdgeInsets.all(30),
              child: FormBuilder(
                key: _fbKey,
                initialValue: {
                  'name': '',
                  'email': '',
                  'password': '',
                  // 'dob': DateTime.now(),
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
                    FormBuilderDateTimePicker(
                      name: 'dob',
                      inputType: InputType.date,
                      format: DateFormat('yyyy-MM-dd'),
                      // onChanged: _onChanged,
                      decoration: InputDecoration(
                        labelText: 'วันเดือนปีเกิด',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(color: Colors.red[300]),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        fillColor: Colors.white60,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        width: 200,
                        child: RaisedButton(
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              // print(_fbKey.currentState.value);
                              _register(_fbKey.currentState.value);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center ,
                            children: [
                              isLoading == true
                                  ? CircularProgressIndicator()
                                  : Text(''),
                              Text('ลงทะเบียน',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))
                            ],
                          ),
                          padding: EdgeInsets.all(20),
                          color: Colors.cyan[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                    SizedBox(height: 20),
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
