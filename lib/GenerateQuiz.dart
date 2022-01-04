import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

Random random = new Random();
String randomNumber = random.nextInt(999999).toString();

class GenerateQuiz extends StatelessWidget {
  const GenerateQuiz({Key? key, this.pin}) : super(key: key);
  final String? pin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz Generation"),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Code is ${pin}', textAlign: TextAlign.left),
                ],
              ),
            ),
            Container(
                child: QrImage(
              data: pin as String,
              version: QrVersions.auto,
              size: 320,
            ))
          ]),
        ));
  }
}
