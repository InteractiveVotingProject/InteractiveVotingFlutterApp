import 'package:flutter/material.dart';
import 'GenerateQuiz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class AnswerQuiz extends StatelessWidget {
  final String quizId;
  AnswerQuiz({Key? key, required this.quizId}) : super(key: key);

   fetchData(String qId)  {
    print('Its here');
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    Query query = databaseRef.orderByChild("pin").equalTo(int.parse(qId));
    var event = query.get();
    //print(event.value.toString());
    return event.toString();
  }
     //var question = fetchData(quizId);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('test ${quizId}'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
            ),
            Text(fetchData(quizId)),
          ],
        ),
      ),
    );
  }
}
