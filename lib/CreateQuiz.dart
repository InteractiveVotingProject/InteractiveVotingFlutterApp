import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'GenerateQuiz.dart';
import 'dart:math';

class CreateQuiz extends StatelessWidget {
  CreateQuiz({Key? key}) : super(key: key);
  final questionController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> future = Firebase.initializeApp();

  void addData(String data) {
    var rng = new Random();
    var pin = rng.nextInt(900000) + 100000;
    databaseRef
        .push()
        .set({'pin': pin, 'question': data, 'comment': 'A good season'});
  }

  void printFirebase() {
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  ElevatedButton(
                    child: Text("1"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text("2"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text("3"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text("4"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text("5"),
                    onPressed: null,
                  ),
                  SizedBox(width: 5),
                ])),
            Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  ElevatedButton(
                    child: Text("6"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text("7"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text("8"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: Text("9"),
                    onPressed: null,
                  ),
                  SizedBox(width: 10),
                ])),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  addData(questionController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GenerateQuiz()),
                  );
                },
                child: const Text('Generate'),
              ),
            ),
          ]),
        ));
  }
}
