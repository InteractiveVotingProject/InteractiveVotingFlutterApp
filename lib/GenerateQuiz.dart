import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:interactive_voting_flutter_app/CreateQuiz.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';
import 'ShowChart.dart';


Random random = new Random();
String randomNumber = random.nextInt(999999).toString();

class GenerateQuiz extends StatelessWidget {
  final String codeId;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  GenerateQuiz({Key? key, required this.codeId}) : super(key: key);
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
              data: pin as String,
              version: QrVersions.auto,
              size: 320,
            )),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowChart(codeId: codeId)),
                  );
                },
                child: const Text('Show Stats'),
              ),
            ),
          ]),
        ));
  }
}


