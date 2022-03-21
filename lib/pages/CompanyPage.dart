import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({Key key}) : super(key: key);

  @override
  _Companytate createState() => _Companytate();
}

class _Companytate extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ข้อมูลบริษัท')),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildHeader(),
                SafeArea(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('ppla.fs',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        Divider(),
                        Text(
                          'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also',
                          textAlign: TextAlign.left,
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(children: <Widget>[
                              Icon(Icons.phone_android, color: Colors.cyan[400])
                            ]),
                            SizedBox(width: 16),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text('Sukrit Nakpanom')
                                  ]),
                                  Row(children: <Widget>[Text('0868826293')])
                                ]),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Wrap(
                            spacing: 20,
                            children: List.generate(
                              9,
                              (int index) => Chip(
                                label: Text('Text ${index + 1}'),
                                avatar: Icon(Icons.star),
                                backgroundColor: Colors.cyan[400],
                              ),
                            )

                            //  <Widget>[
                            //   Chip(
                            //     label: Text('Text'),
                            //     avatar: Icon(Icons.star),
                            //     backgroundColor: Colors.cyan[400],
                            //   ),
                            // ],
                            ),
                        Divider(),
                        buildFooterCompany()
                      ]),
                ))
              ]),
        ));
  }

  Image buildHeader() {
    return Image(
      image: AssetImage('assets/images/building2.png'),
      fit: BoxFit.cover,
    );
  }

  Row buildFooterCompany() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/fish.jpg'),
          radius: 30,
        ),
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/fish.jpg'),
          radius: 30,
        ),
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/fish.jpg'),
          radius: 30,
        ),
        SizedBox(
            width: 60,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Icon(Icons.access_alarm),
              Icon(Icons.ac_unit),
              Icon(Icons.account_balance),
            ]))
      ],
    );
  }
}
