import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf_render/pdf_render.dart';

import 'Resume.dart';

class SummaryPage extends StatelessWidget {
  final Resume resume;

  SummaryPage({Key key, @required this.resume}) : super(key: key);

  static GlobalKey previewContainer = new GlobalKey();
  ScreenshotController screenshotController = new ScreenshotController();


  takeScreenShot() async {
    screenshotController.capture(delay: Duration(seconds: 2)).then((File image) {
      print("****************** $image");
    });
  }


//
//    print("previewContainer $previewContainer");
//    print("previewContainer ${previewContainer.currentContext.findRenderObject()}");

//    RenderRepaintBoundary boundary =
//        previewContainer.currentContext.findRenderObject();
//    ui.Image image = await boundary.toImage();
//    final directory = (await getApplicationDocumentsDirectory()).path;

//    Directory appDocDir = await getApplicationDocumentsDirectory();
//    String directory = appDocDir.path;

//    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//    Uint8List pngBytes = byteData.buffer.asUint8List();
//    print(pngBytes);
//    File imgFile = new File('$directory/screenshot.png');
//    imgFile.writeAsBytes(pngBytes);
//  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
                "Android Developer"), // todo this will be taken from the beginning of the process based on the user pick
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(resume.imagePath))))),
              ),
              new Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  // super dumb width to make sure this takes whole width
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      resume.name,
                      style: Theme.of(context).textTheme.display1,
                    ),
                  )),
              new Row(
                children: <Widget>[Icon(Icons.email), Text(resume.email)],
              ),
              new Row(
                children: <Widget>[Icon(Icons.phone), Text(resume.phone)],
              ),
              new RaisedButton(
                child: Text("Take Screenshot"),
                  onPressed: () {
                takeScreenShot();
              })
            ],
          )),
    );
  }
}
