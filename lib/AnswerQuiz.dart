import 'package:flutter/material.dart';
import 'GenerateQuiz.dart';

class AnswerQuiz extends StatelessWidget {
  final String quizId;
  AnswerQuiz({Key? key, required this.quizId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test ${quizId}'),
      ),
    );
  }
}
