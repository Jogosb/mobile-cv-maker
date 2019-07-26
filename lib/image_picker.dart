import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'Resume.dart';
import 'summary.dart';

class ImagePickerPage extends StatefulWidget {
  final Resume resume;

  const ImagePickerPage({Key key, @required this.resume}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImagePickerState(resume);
}

class ImagePickerState extends State<ImagePickerPage> {
  File _image;
  Resume resume;

  ImagePickerState(this.resume);

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      resume.imagePath = image.path;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryPage(resume: resume),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step II - Photo'),
      ),
      body: Center(
        child: _image == null
            ? Text(
                "Please select your best photo!",
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              )
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
