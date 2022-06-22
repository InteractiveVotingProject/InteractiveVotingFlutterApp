import 'package:flutter/material.dart';
import 'package:interactive_voting_flutter_app/AnswerQuizAccess.dart';
import 'QRReader.dart';
import 'AnswerQuiz.dart';

class ReadCodeAccess extends StatelessWidget {
  ReadCodeAccess({Key? key}) : super(key: key);
  final otpController = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QRReader()),
                  );
                },
                child: const Text('Use QR Reader',
                style: TextStyle(fontSize: 30.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Enter code manually', textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30.0)),
                  TextField(
                    controller: otpController,
                    decoration: InputDecoration(hintText: 'Optional'),
                    style: TextStyle(fontSize: 30.0)
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AnswerQuizAccess(quizId: otpController.text)),
                  );
                },
                child: const Text('Go to Quiz',
                style: TextStyle(fontSize: 30.0)),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
