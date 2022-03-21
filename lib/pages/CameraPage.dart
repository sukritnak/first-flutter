import 'dart:io';

import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  CameraPage({Key key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  List<CameraDescription> cameras;
  CameraDescription camera;
  Widget cameraPreview;

  Future<void> initCamera() async {
    cameras = await availableCameras();
    camera = cameras[0];
    _controller = CameraController(camera, ResolutionPreset.ultraHigh);

    await _controller.initialize();

    cameraPreview = Center(child: CameraPreview(_controller));

    setState(() {
      cameraPreview = cameraPreview;
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ถ่ายรูป'),
          actions: [
            IconButton(
                icon: Icon(Icons.camera_enhance),
                onPressed: () async {
                  Directory tempDir = await getTemporaryDirectory();
                  String newFileName = tempDir.path + '/${DateTime.now()}.jpeg';
                  // จังหวะถ่าย
                  await _controller.takePicture(newFileName);
                  Navigator.pushNamed(context, 'camerastack/picture',
                      arguments: {'path': newFileName});
                  // print('newFileName' + newFileName);
                })
          ],
        ),
        drawer: Menu(),
        body: Container(
          child: cameraPreview,
        ));
  }
}
