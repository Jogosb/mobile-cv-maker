import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'Resume.dart';
import 'image_picker.dart';

void main() => runApp(CVMakerApp());

class CVMakerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile CV Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeveloperInfoPage(title: 'Step I - Basic Info'),
    );
  }
}

class DeveloperInfoPage extends StatefulWidget {
  DeveloperInfoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DeveloperInfoPageState createState() => _DeveloperInfoPageState();
}

class _DeveloperInfoPageState extends State<DeveloperInfoPage> {
  int currentStep = 0;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static Resume resume = new Resume();

  List<Step> steps = [
    new Step(
        title: const Text('Name'),
        isActive: true,
        state: StepState.indexed,
        content: new TextFormField(
          keyboardType: TextInputType.text,
          autocorrect: false,
          onSaved: (String value) {
            resume.name = value;
          },
          maxLines: 1,
          validator: (value) {
            if (value.isEmpty || value.length < 1) {
              return 'Please enter name';
            }
          },
          decoration: new InputDecoration(
              labelText: 'Enter your name',
              hintText: 'Enter a name',
              icon: const Icon(Icons.person),
              labelStyle:
                  new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
    new Step(
        title: const Text('Phone'),
        isActive: true,
        state: StepState.indexed,
        content: new TextFormField(
          keyboardType: TextInputType.phone,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || value.length < 8) {
              return 'Please enter valid number';
            }
          },
          onSaved: (String value) {
            resume.phone = value;
          },
          maxLines: 1,
          decoration: new InputDecoration(
              labelText: 'Enter your number',
              hintText: 'Enter a number',
              icon: const Icon(Icons.phone),
              labelStyle:
                  new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
    new Step(
        title: const Text('Email'),
        isActive: true,
        state: StepState.complete,
        content: new TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || !value.contains('@')) {
              return 'Please enter valid email';
            }
          },
          onSaved: (String value) {
            resume.email = value;
          },
          maxLines: 1,
          decoration: new InputDecoration(
              labelText: 'Enter your email',
              hintText: 'Enter a email address',
              icon: const Icon(Icons.email),
              labelStyle:
                  new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePickerPage(resume: resume),
          ),
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
            child: new Form(
          key: _formKey,
          child: new ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(
                "Let's kick off CV-making process! Please enter some basic info about you!",
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ),
            new Stepper(
              steps: steps,
              type: StepperType.vertical,
              currentStep: this.currentStep,
//              TODO it's an option for changing buttons text - it's not that easy it appears
              // https://github.com/flutter/flutter/issues/11133
//              controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
//                return Row(
//                  mainAxisSize: MainAxisSize.max,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    RaisedButton(
//                      onPressed: onStepCancel,
//                      child: const Text('Back!'),
//                    ),
//                    RaisedButton(
//                      onPressed: onStepContinue,
//                      child: const Text('Next!'),
//                    ),
//                  ],
//                );
//              },
              onStepContinue: () {
                setState(() {
                  if (currentStep < steps.length - 1) {
                    currentStep = currentStep + 1;
                  } else {
                    currentStep = 0;
                    _submitDetails();
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (currentStep > 0) {
                    currentStep = currentStep - 1;
                  } else {
                    currentStep = 0;
                  }
                });
              },
              onStepTapped: (step) {
                setState(() {
                  currentStep = step;
                });
              },
            ),
            new RaisedButton(
              child: new Text(
                "GO TO STEP II - PHOTO!",
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: _submitDetails,
              color: Colors.blue,
            ),
          ]),
        )));
  }
}
