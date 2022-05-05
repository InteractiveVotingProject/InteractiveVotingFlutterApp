import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:interactive_voting_flutter_app/ReadCode.dart';
import 'GenerateQuiz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';


class AnswerQuiz extends StatefulWidget {
  final String quizId;
  const AnswerQuiz({Key? key,required this.quizId}) : super(key: key);
 
  @override
  State<StatefulWidget> createState() => _AnswerQuiz(this.quizId);
}

class _AnswerQuiz extends State<AnswerQuiz> {

final String quizId;
//  _AnswerQuiz(this.quizId);
  final answerController = TextEditingController();
  String val = "";

  _AnswerQuiz(this.quizId);
  
   fetchData(String qId) {
    //print('Its here');
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

    databaseRef
        .child(qId)
        .child("question")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());
      
      setState((){
        val = dataSnapshot.value.toString();
      });
      
    });
    return val;
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
            
            Text("Question : " + fetchData(quizId)+ '\n'),
            TextField( 
              maxLength: 300,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 30),
                border: OutlineInputBorder(),
                hintText: 'Write your answers',
              ),
              controller: answerController,
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  //addData(questionController.text);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const GenerateQuiz()),
                  // );
                },
                child: const Text('Submit Answer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
