// import 'package:firstFlutter/models/product.dart';

// ลองใช้ แบบไม่มี model dynamic

import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> course = [];
  bool isLoading = true;

  _getData() async {
    var url = 'https://api.codingthailand.com/api/course';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> product = convert.jsonDecode(response.body);
      setState(() {
        course = product['data'];
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
          title: Text('สินค้า'),
        ),
        drawer: Menu(),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(course[index]['title']),
                    subtitle: Text(course[index]['detail']),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, 'productstack/detail',
                          arguments: {
                            'id': course[index]['id'],
                            'title': course[index]['title']
                          });
                    },
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(course[index]['picture']))),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: course.length));
  }
}
