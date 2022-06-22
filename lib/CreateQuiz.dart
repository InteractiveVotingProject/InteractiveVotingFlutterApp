import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Homepage.dart';
import 'GenerateQuiz.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

Random rng = new Random();
String pin = (rng.nextInt(900000) + 100000).toString();

class CreateQuiz extends StatefulWidget {
  //final String quizId;
  CreateQuiz({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateQuiz();
}

class _CreateQuiz extends State<CreateQuiz> {
  final questionController = TextEditingController();
  final isSelected = <bool>[false, false, false, false, false];
  final mcqController = TextEditingController();
  final mcqController2 = TextEditingController();
  final mcqController3 = TextEditingController();
  final mcqController4 = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> future = Firebase.initializeApp();

  String pin = '';

  void addData(String question, String choice1, String choice2, String choice3,
      String choice4, String corrAns) {
    var rng = new Random();
    pin = (rng.nextInt(900000) + 100000).toString();
    //print('test' + databaseRef.child("811280").toString());
    databaseRef
        .child(pin)
        .child("question")
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value.toString() != 'null') {
        pin = (rng.nextInt(900000) + 100000).toString();
      }
      //print('here ' + dataSnapshot.value.toString());
    });
    DateTime now = DateTime.now();
    String creationDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    databaseRef.child(pin).set({
      'question': question,
      'choice1': choice1,
      'choice2': choice2,
      'choice3': choice3,
      'choice4': choice4,
      'correctAnswer': corrAns,
      'revealAnswer': false,
      'creationDate': creationDate
    });
  }

  bool valueCb1 = false;
  bool valueCb2 = false;
  bool valueCb3 = false;
  bool valueCb4 = false;

  String getCorrAns() {
    String correctAns = "";
    if (valueCb1) correctAns += "1;";
    if (valueCb2) correctAns += "2;";
    if (valueCb3) correctAns += "3;";
    if (valueCb4) correctAns += "4;";

    return correctAns;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
          );
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Launch a quiz"),
            ),
            body: Center(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Write your question', textAlign: TextAlign.left),
                      TextField(
                        controller: questionController,
                      ),
                      SizedBox(height: 30),
                      Text('Select good answer(s) :',
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: ui.TextDirection.ltr,
                        children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            ElevatedButton(
                              child: Text("1"),
                              onPressed: null,
                            ),
                            SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: mcqController,
                                  decoration:
                                      new InputDecoration(hintText: "Choice"),
                                )),
                            Checkbox(
                              value: this.valueCb1,
                              onChanged: (bool? valueCb1) {
                                setState(() {
                                  this.valueCb1 = valueCb1!;
                                });
                              },
                            ),
                            ElevatedButton(
                              child: Text("2"),
                              onPressed: null,
                            ),
                            SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: mcqController2,
                                  decoration:
                                      new InputDecoration(hintText: "Choice"),
                                )),
                            Checkbox(
                              value: this.valueCb2,
                              onChanged: (bool? valueCb2) {
                                setState(() {
                                  this.valueCb2 = valueCb2!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            ElevatedButton(
                              child: Text("3"),
                              onPressed: null,
                            ),
                            SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: mcqController3,
                                  decoration:
                                      new InputDecoration(hintText: "Choice"),
                                )),
                            Checkbox(
                              value: this.valueCb3,
                              onChanged: (bool? valueCb3) {
                                setState(() {
                                  this.valueCb3 = valueCb3!;
                                });
                              },
                            ),
                            ElevatedButton(
                              child: Text("4"),
                              onPressed: null,
                            ),
                            SizedBox(
                                width: 80,
                                child: TextField(
                                  controller: mcqController4,
                                  decoration:
                                      new InputDecoration(hintText: "Choice"),
                                )),
                            Checkbox(
                              value: this.valueCb4,
                              onChanged: (bool? valueCb4) {
                                setState(() {
                                  this.valueCb4 = valueCb4!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ])),
                Container(
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      String corrAns = getCorrAns();
                      addData(
                          questionController.text,
                          mcqController.text,
                          mcqController2.text,
                          mcqController3.text,
                          mcqController4.text,
                          corrAns);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GenerateQuiz(codeId: pin)),
                      );
                    },
                    child: const Text('Generate'),
                  ),
                ),
              ]),
            )));
  }
}
