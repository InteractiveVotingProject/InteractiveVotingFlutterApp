import 'package:flutter/material.dart';
import 'package:interactive_voting_flutter_app/History.dart';
import 'CreateQuiz.dart';
import 'ReadCode.dart';
import 'Homepage.dart';

class HomepageAccess extends StatelessWidget {
  const HomepageAccess({Key? key}) : super(key: key);
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
                  style: TextStyle(fontSize: 40.0),
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
                  style: TextStyle(fontSize: 40.0),
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
              child: OutlinedButton(
                child: Text(
                  'Previous History',
                  style: TextStyle(fontSize: 40.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History()),
                  );
                },
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                  child: Text(
                    'DISABLE ACCESSIBILITY MODE',
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(25)),
                  ),
                )),
          ]))),
    );
  }
}
