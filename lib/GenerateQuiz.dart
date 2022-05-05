import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

Random random = new Random();
String randomNumber = random.nextInt(999999).toString();

class GenerateQuiz extends StatelessWidget {
    final String codeId;

  const GenerateQuiz({Key? key, required this.codeId}) : super(key: key);
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
                  Text('Code is ' + codeId, textAlign: TextAlign.left),
                ],
              ),
            ),
            Container(
                child: QrImage(
              data: randomNumber,
              version: QrVersions.auto,
              size: 320,
            ))
          ]),
        ));
  }
}
