import 'dart:async';

import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  String resultScan;
  Completer<GoogleMapController> _controller = Completer();

  _openGoogleMapApp(double lat, double long) async {
    var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      // drawer: Menu(),
      body: Center(
        child: GoogleMap(
          mapType: MapType.normal,
          markers: <Marker>[
            Marker(
                markerId: MarkerId('marker1'),
                position: LatLng(14.438774484530489, 101.37226961930675),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueCyan),
                infoWindow: InfoWindow(
                    title: 'สวัสดีครับที่นี่เขาใหญ๋',
                    snippet: 'ยินดีต้อนรับ',
                    onTap: () {
                      _openGoogleMapApp(14.438774484530489, 101.37226961930675);
                    })),
          ].toSet(),
          // mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(14.438774484530489, 101.37226961930675),
            zoom: 16,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
