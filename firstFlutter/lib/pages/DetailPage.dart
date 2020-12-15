import 'package:firstFlutter/models/detail.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> course;
  List<Chapter> chapter = [];
  bool isLoading = true;
  final fNumber = NumberFormat('#,###');

  _getData(int id) async {
    var url = 'https://api.codingthailand.com/api/course/$id';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      final Detail detail = Detail.fromJson(jsonResponse);
      setState(() {
        chapter = detail.chapter;
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    print('init detail');
    Future.delayed(Duration.zero, () {
      print('init detail delayed ****');
      _getData(course['id']);
    }); // เพราะว่า build เกิดก่อน เลยต้องเขียนตัวนี้เพื่อรอ course id
  }

  @override
  Widget build(BuildContext context) {
    print('build detail');
    course = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text('${course['title']}'),
          // automaticallyImplyLeading: false, // leading ด้านหน้าที่นี้คือปุ่ม back
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(chapter[index].chTitle),
                    subtitle: Text(chapter[index].chDateadd),
                    trailing: Chip(
                      label: Text('${fNumber.format(chapter[index].chView)}'),
                      backgroundColor: Colors.cyan[100],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: chapter.length));
  }
}
