// ลองแบบไม่มี model
// import 'package:firstFlutter/models/room.dart';
import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  RoomPage({Key key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<dynamic> rooms = [];
  bool isLoading = true;

  _getData() async {
    var url = 'https://codingthailand.com/api/get_rooms.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> room = convert.jsonDecode(response.body);
      setState(() {
        rooms = room;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    print('product no model');
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('ห้องพัก'),
        ),
        drawer: Menu(),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(rooms[index]['name']),
                    subtitle: Text(rooms[index]['status']),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: rooms.length));
  }
}
