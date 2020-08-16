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

  Result(confidence, label){
    print('Inside Selected Image\n');
    this.confidence = confidence;
    this.label = label;
//    this.path = path;
//    confidence = "No value assigned yet";
//    processImage();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text('Results')
      ),

      body: Center(
          child: Column(
            children: <Widget>[
              Text("label:" + label),
              Text("confidence:" + confidence)
            ],
          )
      )
    );
  }
}
