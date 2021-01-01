import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class BarcodePage extends StatefulWidget {
  BarcodePage({Key key}) : super(key: key);

  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  String resultScan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barcode/QRCode')),
      drawer: Menu(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('result: $resultScan'),
              RaisedButton(
                  child: Text('Scan..'),
                  onPressed: () async {
                    // var options = ScanOptions(
                    //     strings: {'cancle': 'ยกเลิก'},
                    //     autoEnableFlash: false,
                    //     android: AndroidOptions(useAutoFocus: true));

                    var result = await BarcodeScanner.scan();
                    // var result = await BarcodeScanner.scan(options: options);

                    setState(() {
                      resultScan = result.rawContent;
                    });
                    print('------');
                    print(result
                        .type); // The result type (barcode, cancelled, failed)
                    print(result.rawContent); // The barcode content
                    print(result.format); // The barcode format (as enum)
                    print(result
                        .formatNote); // If a unknown format was scanned this field contains a note
                    print('------');
                  }),
            ]),
      ),
    );
  }
}
