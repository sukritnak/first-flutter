import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map> customers = [];
  final _fbKey = GlobalKey<FormBuilderState>();

  _getCustomers() async {}

  _insertForm() {
    Alert(
        context: context,
        title: "เพิ่มข้อมูลลูกค้า",
        // closeFunction: () {},
        content: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'name': '',
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
                ],
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              // Navigator.pop(context);
              if (_fbKey.currentState.saveAndValidate()) {
                Navigator.of(context).pop();
                print(_fbKey.currentState.value);
                // _register(_fbKey.currentState.value);
              }
            },
            child: Text(
              "เพิ่มข้อมูล",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  void initState() {
    super.initState();
    _getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ลูกค้า'),
          actions: [
            IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  _insertForm();
                })
          ],
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(''),
                subtitle: Text(''),
                trailing: Chip(
                  label: Text(''),
                  backgroundColor: Colors.cyan[100],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: customers.length));
  }
}
