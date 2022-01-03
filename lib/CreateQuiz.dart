import 'package:flutter/material.dart';
import 'GenerateQuiz.dart';

class CreateQuiz extends StatelessWidget {
  CreateQuiz({Key? key}) : super(key: key);
  final questionController = TextEditingController();
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
