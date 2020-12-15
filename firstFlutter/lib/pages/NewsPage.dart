// ลองแบบไม่มี model
// import 'package:firstFlutter/models/room.dart';
import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResults = 0;
  bool isLoading = true;

  _getData() async {
    try {
      var url =
          'https://newsapi.org/v2/top-headlines?country=th&apiKey=ae4c16640c364268b2bbdafedea1c4d5';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> news = convert.jsonDecode(response.body);
        setState(() {
          totalResults = news['totalResults'];
          articles = news['articles'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
          title: totalResults > 0 ? Text('ข่าวสาร $totalResults ข่าว') : null,
        ),
        drawer: Menu(),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: articles[index]['urlToImage'] != null
                                    ? Ink.image(
                                        image: NetworkImage(
                                            articles[index]['urlToImage']),
                                        fit: BoxFit.cover,
                                      )
                                    : Ink.image(
                                        image: NetworkImage(
                                            'https://picsum.photos/500/200'),
                                        fit: BoxFit.cover,
                                      )),
                            Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                        articles[index]['source']['name'],
                                        style:
                                            TextStyle(color: Colors.white70))))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(articles[index]['title']),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                articles[index]['author'] != null
                                    ? Chip(
                                        // label: Text(articles[index]['author']),
                                        label: articles[index]['author']
                                                    .length <
                                                20
                                            ? Text(articles[index]['author'])
                                            : Text(
                                                '${articles[index]['author'].substring(0, 20)} ...'),
                                        avatar: Icon(Icons.person_pin),
                                      )
                                    : Text(''),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(DateFormat.yMMMd().add_Hms().format(
                                      DateTime.parse(
                                          articles[index]['publishedAt'])))
                                ]),
                          ],
                        ),
                      )
                    ],
                  ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: articles.length));
  }
}
