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
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text('Crop Disease'),
        backgroundColor: Colors.green[900],
      ),

      body: Center(
          child: Container(
//            margin: EdgeInsets.only(top: 150, bottom: 100),
//            padding: EdgeInsets.all(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Camera.TakePictureScreen(camera: camera,))) ;
                      },
                      padding: EdgeInsets.all(30),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                        Text('Open Camera', style: TextStyle(fontSize: 30)),
                        Icon(Icons.camera_alt)
                        ],
                      ),
                    )


                  ),
                ),
                
                Container(
                  margin: EdgeInsets.only( top: 50),
                  child: RaisedButton(
                    padding: EdgeInsets.all(30),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Gallery.PickImageDemo()));
                    },

                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text('Open Gallery', style: TextStyle(fontSize: 30)),
                          Icon(Icons.image)
                        ],
                      ),
                    )

                  )
                ),

                
              ],
            ),  
          )
          
        )
    );
  }
}

// A screen that allows users to take a picture using a given camera.

