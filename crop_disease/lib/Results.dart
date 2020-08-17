import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'Camera.dart' as Camera;

import 'package:image_picker/image_picker.dart';

import 'Gallery.dart' as Gallery;

import 'package:tflite/tflite.dart';


class Result extends StatelessWidget {

  var image, path;
  String res;
  var recognitions, list;

  String confidence, label;

  Result(confidence, label, path){
    print('Inside Selected Image\n');
    this.confidence = confidence;
    this.label = label;
    this.path = path;
//    convertlabel();
//    this.path = path;
//    confidence = "No value assigned yet";
//    processImage();
  }


  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text('Results')
      ),

      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                child: Image.file(File(path)),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: ListTile(
                    title: Text("Disease"),
                    subtitle: Text(label),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  child: ListTile(
                    title: Text("Confidence"),
                    subtitle: Text(confidence),
                  ),
                ),
              ),
//              Text("label:" + label),
//              Text("confidence:" + confidence)
            ],
          )
      )
    );
  }
}
