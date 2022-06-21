import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'GenerateQuiz.dart';
import 'dart:math';

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
<<<<<<< HEAD
  final mcqController = TextEditingController();
  final mcqController2 = TextEditingController();
  final mcqController3 = TextEditingController();
  final mcqController4 = TextEditingController();
=======
  final isSelected = <bool>[false, false, false, false, false];
>>>>>>> UI

  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> future = Firebase.initializeApp();

<<<<<<< HEAD
  void addData(String question, String choice1, String choice2, String choice3,
      String choice4, String corrAns) {
    //print('test' + databaseRef.child("811280").toString());
=======
  String pin = '';

  void addData(String data) {
    var rng = new Random();
    pin = (rng.nextInt(900000) + 100000).toString();
>>>>>>> UI
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
    return Scaffold(
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
                  Text('Select good answer(s) :', textAlign: TextAlign.left),
                ],
              ),
            ),
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
<<<<<<< HEAD
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
=======
                  ToggleButtons(
                    color: Colors.black.withOpacity(0.60),
                    selectedColor: Color(0xFF6200EE),
                    selectedBorderColor: Color(0xFF6200EE),
                    fillColor: Color(0xFF6200EE).withOpacity(0.08),
                    splashColor: Color(0xFF6200EE).withOpacity(0.12),
                    hoverColor: Color(0xFF6200EE).withOpacity(0.04),
                    borderRadius: BorderRadius.circular(4.0),
                    constraints: BoxConstraints(minHeight: 36.0),
                    isSelected: isSelected,
                    onPressed: (index) {
                      fillColor:
                      Color(0x222222).withOpacity(0.08);
                    },
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('1'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('2'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('3'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('4'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('5'),
                      ),
                    ],
                  )
>>>>>>> UI
                ])),
            Container(
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
<<<<<<< HEAD
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
=======
                  addData(
                    questionController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GenerateQuiz(pin: pin)),
>>>>>>> UI
                  );
                },
                child: const Text('Generate'),
              ),
            ),
          ]),
        ));
  }
}
