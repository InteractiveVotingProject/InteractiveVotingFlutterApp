import 'package:flutter/material.dart';
import 'QRReader.dart';
import 'AnswerQuiz.dart';

class ReadCode extends StatelessWidget {
  ReadCode({Key? key}) : super(key: key);
  final otpController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        title: Text('Answering Quiz'),
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
                child: const Text('Use QR Reader'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Enter code manually', textAlign: TextAlign.left),
                  TextField(
                    controller: otpController,
                    decoration: InputDecoration(hintText: 'Optional'),
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
                            AnswerQuiz(quizId: otpController.text)),
                  );
                },
                child: const Text('Go to Quiz'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
