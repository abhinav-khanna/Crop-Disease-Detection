import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'SelectedImage.dart' as selectedimage;


class PickImageDemo extends StatefulWidget {
  PickImageDemo() : super();

  final String title = "Flutter Pick Image demo";

  @override
  _PickImageDemoState createState() => _PickImageDemoState();
}

class _PickImageDemoState extends State<PickImageDemo> {
  io.File imageURI;
  String result;
  String path;

  Future getImage() async {
//    final pickedFile = await picker.getImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = io.File(image.path);
      path = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Image Picker Example'),
          ),
          body: Center(child:
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: imageURI == null
                        ? Text('No image selected.')
                        : Container(
                height: 200,
                child: Image.file(imageURI),
            ),
                  ),
                  RaisedButton(
                    onPressed: getImage,
                    child: Text('Add image from gallery'),
                  ),

                  RaisedButton(
                    child: Text('Process Image'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => selectedimage.SelectedImage(imageURI, path)));
                    },
                  )

                ],
              ),
            )
          )

          )
        );
  }
}