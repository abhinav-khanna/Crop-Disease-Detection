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
import 'Results.dart' as results;


class SelectedImage extends StatelessWidget {

  var image, path;
  String res;
  var recognitions, list;

  String confidence, label;

  SelectedImage(image, path){
    print('Inside SelectedImage\n');
    this.image = image;
    this.path = path;
//    confidence = "No value assigned yet";
    processImage();
  }

  void processImage() async {
    print('Waiting for res\n');
    res = await Tflite.loadModel(
        model: "assets/model_unquant_1.tflite",
        labels: "assets/labels_1.txt",
        numThreads: 1, // defaults to 1
//        isAsset: true, // defaults to true, set to false to load resources outside assets
//        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );

    print('res:' + res);

    recognitions = await Tflite.runModelOnImage(
        path: path,   // required
        imageMean: 0.0,   // defaults to 117.0
        imageStd: 255.0,  // defaults to 1.0
        numResults: 2,    // defaults to 5
        threshold: 0.2,   // defaults to 0.1
        asynch: true      // defaults to true
    );

    print(recognitions);
    confidence = recognitions[0]['confidence'].toString();
    label = recognitions[0]['label'].toString();
    print("confidence:" + confidence.toString());
    print(confidence.runtimeType);

//    print(recognitions["confidence"].toString());

//    list = recognitions.values.toList();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Selected Image')
      ),

      body: Center(
        child: Column(
          children: <Widget>[
            Text('Processing image for Diseases......\n'),
            RaisedButton(
              child: Text('View Results'),
              padding: EdgeInsets.all(10),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => results.Result(confidence, label))) ;
              },
            )
          ],
        )
      ),
    );
  }
}
