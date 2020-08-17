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
          backgroundColor: Colors.lightGreen,
          appBar: AppBar(
            title: Text('Image Picker Example'),
            backgroundColor: Colors.green[900],
          ),
          body: Center(child:
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: imageURI == null
                        ? Text('No image selected.')
                        : Container(
                height: 200,
                child: Image.file(imageURI),
            ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: RaisedButton(
                      padding: EdgeInsets.all(30),
                      onPressed: getImage,
                      child: Text('Add image from gallery', style: TextStyle(fontSize: 20),),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        padding: EdgeInsets.all(30),
                        child: Text('Process Image', style: TextStyle(fontSize: 20),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => selectedimage.SelectedImage(imageURI, path)));
                        },
                      )
                  )


                ],
              ),
            )
          )

          )
        );
  }
}