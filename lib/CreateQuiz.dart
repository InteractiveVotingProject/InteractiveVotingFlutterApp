import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'GenerateQuiz.dart';
import 'dart:math';

Random rng = new Random();
String pin = (rng.nextInt(900000) + 100000).toString();

// ignore: must_be_immutable
class CreateQuiz extends StatelessWidget {
//   //final String quizId;
//   CreateQuiz({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _CreateQuiz();
// }

// class _CreateQuiz extends State<CreateQuiz> {
  final questionController = TextEditingController();
  final mcqController = TextEditingController();
  final mcqController2 = TextEditingController();
  final mcqController3 = TextEditingController();
  final mcqController4 = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> future = Firebase.initializeApp();

  void addData(String question, String choice1, String choice2, String choice3,
      String choice4) {
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
      'correctAnswer': 'A good season'
    });
  }

  bool value = false;

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
                  Container(
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                          child: Text("1"),
                          onPressed: null,
                          // () {
                          //   //mcqController.text;
                          // },
                        ),
                        SizedBox(
                            width: 120,
                            child: TextField(
                              controller: mcqController,
                              decoration:
                                  new InputDecoration(hintText: "Choice"),
                            )),
                        ElevatedButton(
                          child: Text("2"),
                          onPressed: null,
                        ),
                        SizedBox(
                            width: 120,
                            child: TextField(
                              controller: mcqController2,
                              decoration:
                                  new InputDecoration(hintText: "Choice"),
                            )),
                        // Checkbox(
                        //   value: this.value,
                        //   onChanged: (bool? value) {
                        //     setState(() {
                        //       this.value = value!;
                        //     });
                        //   },
                        // ),
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
                            width: 120,
                            child: TextField(
                              controller: mcqController3,
                              decoration:
                                  new InputDecoration(hintText: "Choice"),
                            )),
                        ElevatedButton(
                          child: Text("4"),
                          onPressed: null,
                        ),
                        SizedBox(
                            width: 120,
                            child: TextField(
                              controller: mcqController4,
                              decoration:
                                  new InputDecoration(hintText: "Choice"),
                            )),
                      ],
                    ),
                  ),
                  // Container(
                  //   child: Row(
                  //     children: <Widget>[
                  //       ElevatedButton(
                  //         child: Text("3"),
                  //         onPressed: null,
                  //       ),
                  //       SizedBox(
                  //           width: 250,
                  //           child: TextField(
                  //             decoration: new InputDecoration(
                  //                 hintText: "Enter Choice 3"),
                  //             controller: mcqController3,
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     children: <Widget>[
                  //       ElevatedButton(
                  //         child: Text("4"),
                  //         onPressed: null,
                  //       ),
                  //       SizedBox(
                  //           width: 200,
                  //           child: TextField(
                  //             decoration: new InputDecoration(
                  //                 hintText: "Enter Choice 4"),
                  //             controller: mcqController4,
                  //           )),
                  //     ],
                  //   ),
                  // ),
                ])),
            Container(
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  addData(
                      questionController.text,
                      mcqController.text,
                      mcqController2.text,
                      mcqController3.text,
                      mcqController4.text);
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
        ));
  }
}
