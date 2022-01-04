import 'package:flutter/material.dart';
import 'CreateQuiz.dart';
import 'ReadCode.dart';
// import 'dbDetails.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key, this.code}) : super(key: key);
  final String? code;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Quiz App'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: OutlinedButton(
                child: Text(
                  "Launch a quiz",
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateQuiz()),
                    //MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: OutlinedButton(
                child: Text(
                  'Answer',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadCode()),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Session ID is ${code}', textAlign: TextAlign.left),
                ],
              ),
            ),
          ]))),
    );
  }
}
