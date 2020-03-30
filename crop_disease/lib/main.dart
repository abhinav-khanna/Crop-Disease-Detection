import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'Camera.dart' as Camera;

import 'package:image_picker/image_picker.dart';

import 'Gallery.dart' as Gallery;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget{
  final CameraDescription camera;

  const HomeScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Disease'),
      ),

      body: Container(
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Text('Open Camera'),
              padding: EdgeInsets.all(10),
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => Camera.TakePictureScreen(camera: camera,))) ;
              },
            ),
            
            RaisedButton(
              child: Text('Open Gallery'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Gallery.PickImageDemo()));
              },
            )
          ],
        ),
      )
    );
  }
}

// A screen that allows users to take a picture using a given camera.

