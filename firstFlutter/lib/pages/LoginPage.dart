import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

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
              padding: EdgeInsets.all(10),
              child: FormBuilder(
                key: _formKey,
                initialValue: {
                  'email': '',
                  'password': '',
                },
                // autovalidate: true,
                autovalidateMode: AutovalidateMode.always,
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
                  FormBuilderTextField(
                      name: 'password',
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
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
                        FormBuilderValidators.minLength(context,
                            3, errorText: 'ขั้นต่ำ 3 ตัว'),
                      ]),
                      keyboardType: TextInputType.visiblePassword,
                    ),
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
