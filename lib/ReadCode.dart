import 'package:flutter/material.dart';
import 'QRReader.dart';
import 'AnswerQuiz.dart';

class ReadCode extends StatelessWidget {
  ReadCode({Key? key}) : super(key: key);
<<<<<<< HEAD
  final otpController = TextEditingController();

=======
  final codeController = TextEditingController();
  @override
>>>>>>> UI
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
                child: const Text('Use QR Reader'),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Enter code manually', textAlign: TextAlign.left),
                  TextField(
<<<<<<< HEAD
                    controller: otpController,
                    decoration: InputDecoration(hintText: 'Optional'),
=======
                    controller: codeController,
>>>>>>> UI
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
<<<<<<< HEAD
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AnswerQuiz(quizId: otpController.text)),
                  );
=======
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Homepage(code: codeController.text)));
>>>>>>> UI
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
