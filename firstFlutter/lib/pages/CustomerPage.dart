import 'package:firstFlutter/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map> customers = [];
  final _fbKey = GlobalKey<FormBuilderState>();
  DBHelper dbHelper;
  Database db;

  _getCustomers() async {
    db = await dbHelper.db;
    var cust = await db.rawQuery(('SELECT * FROM customers ORDER BY id DESC'));
    setState(() {
      customers = cust;
    });
  }

  _insertCustomer(Map values) async {
    db = await dbHelper.db;
    await db
        .rawInsert('INSERT INTO customers(name) VALUES (?)', [values['name']]);

    _getCustomers();
  }

  _updateCustomer(int id, Map values) async {
    db = await dbHelper.db;
    await db.rawUpdate(
        'UPDATE customers SET name=? WHERE id=?', [values['name'], id]);
    _getCustomers();
  }

  _deleteCustomer(int id) async {
    db = await dbHelper.db;
    await db.rawUpdate('DELETE FROM customers WHERE id=?', [id]);
    _getCustomers();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _getCustomers();
  }

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
                _insertCustomer(_fbKey.currentState.value);
                Navigator.of(context).pop();
                // print(_fbKey.currentState.value);
              }
            },
            child: Text(
              "เพิ่มข้อมูล",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }



    _updateForm(int id, String name) {
    Alert(
        context: context,
        title: "แก้ไขข้อมูลลูกค้า",
        // closeFunction: () {},
        content: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                'name': '$name',
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
                _updateCustomer(id, _fbKey.currentState.value);
                Navigator.of(context).pop();
                // print(_fbKey.currentState.value);
              }
            },
            child: Text(
              "แก้ไข",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ลูกค้า'),
          // automaticallyImplyLeading: false,
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
              return Dismissible(
                // key dismiss รับเป็น string
                key: Key(customers[index]['id'].toString()),
                child: ListTile(
                  title: Text('${customers[index]['name']}'),
                  subtitle: Text('${customers[index]['id']}'),
                ),
                // ปัดซ้าย
                background: Container(
                  color: Colors.greenAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.edit, color: Colors.white),
                      Text(
                        'แก้ไข',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      Text(
                        'ลบ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "ยืนยันการลบ",
                      desc:
                          "แน่ใจว่าจะลบข้อมูลคุณ ${customers[index]['name']} หรือไม่",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "ใช่",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteCustomer(customers[index]['id']);
                          },
                          color: Colors.red,
                        ),
                        DialogButton(
                          child: Text(
                            "ยกเลิก",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
                        )
                      ],
                    ).show();
                  } else {
                    _updateForm(customers[index]['id'], customers[index]['name']);
                  }
                  // ไม่ให้มันปัดหายไป
                  return false;
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: customers.length));
  }
}
