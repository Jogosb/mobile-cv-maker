import 'dart:io';
import 'package:flutter/material.dart';
import 'Resume.dart';

class SummaryPage extends StatelessWidget {
  final Resume resume;

  SummaryPage({Key key, @required this.resume}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )
          ],
        ));
  }
}
