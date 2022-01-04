import 'package:flutter/material.dart';
import 'GenerateQuiz.dart';

class CreateQuiz extends StatelessWidget {
  CreateQuiz({Key? key}) : super(key: key);
  final questionController = TextEditingController();
  final isSelected = <bool>[false, false, false, false, false];
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
                    onPressed: (index) {},
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
