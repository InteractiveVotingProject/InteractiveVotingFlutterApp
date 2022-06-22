import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:interactive_voting_flutter_app/HomepageAccess.dart';
import 'GenerateQuiz.dart';
import 'dart:math';

import 'GenerateQuizAccess.dart';

Random rng = new Random();
String pin = (rng.nextInt(900000) + 100000).toString();

class CreateQuizAccess extends StatefulWidget {
  //final String quizId;
  CreateQuizAccess({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateQuizAccess();
}

class _CreateQuizAccess extends State<CreateQuizAccess> {
  final questionController = TextEditingController();
  final mcqController = TextEditingController();
  final mcqController2 = TextEditingController();
  final mcqController3 = TextEditingController();
  final mcqController4 = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> future = Firebase.initializeApp();

  void addData(String question, String choice1, String choice2, String choice3,
      String choice4, String corrAns) {
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
    databaseRef.child(pin).set({
      'question': question,
      'choice1': choice1,
      'choice2': choice2,
      'choice3': choice3,
      'choice4': choice4,
      'correctAnswer': corrAns,
      'revealAnswer': false
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
            MaterialPageRoute(builder: (context) => HomepageAccess()),
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
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Write your question',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      TextField(
                        controller: questionController,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Select good answer(s) :',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                ElevatedButton(
                                  child: Text("1",
                                      style: TextStyle(fontSize: 20.0)),
                                  onPressed: null,
                                ),
                                SizedBox(
                                    width: 200,
                                    child: TextField(
                                        controller: mcqController,
                                        decoration: new InputDecoration(
                                            hintText: "Choice"),
                                        style: TextStyle(fontSize: 20.0))),
                                Checkbox(
                                  value: this.valueCb1,
                                  onChanged: (bool? valueCb1) {
                                    setState(() {
                                      this.valueCb1 = valueCb1!;
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
                                  child: Text("2",
                                      style: TextStyle(fontSize: 20.0)),
                                  onPressed: null,
                                ),
                                SizedBox(
                                    width: 200,
                                    child: TextField(
                                        controller: mcqController2,
                                        decoration: new InputDecoration(
                                            hintText: "Choice"),
                                        style: TextStyle(fontSize: 20.0))),
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
                                  child: Text("3",
                                      style: TextStyle(fontSize: 20.0)),
                                  onPressed: null,
                                ),
                                SizedBox(
                                    width: 200,
                                    child: TextField(
                                        controller: mcqController3,
                                        decoration: new InputDecoration(
                                            hintText: "Choice"),
                                        style: TextStyle(fontSize: 20.0))),
                                Checkbox(
                                  value: this.valueCb3,
                                  onChanged: (bool? valueCb3) {
                                    setState(() {
                                      this.valueCb3 = valueCb3!;
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
                                  child: Text("4",
                                      style: TextStyle(fontSize: 20.0)),
                                  onPressed: null,
                                ),
                                SizedBox(
                                    width: 200,
                                    child: TextField(
                                        controller: mcqController4,
                                        decoration: new InputDecoration(
                                            hintText: "Choice"),
                                        style: TextStyle(fontSize: 20.0))),
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
                  margin: EdgeInsets.all(5),
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
                            builder: (context) =>
                                GenerateQuizAccess(codeId: pin)),
                      );
                    },
                    child: const Text(
                      'Generate',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
