import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class AnswerQuiz extends StatefulWidget {
  final String quizId;
  const AnswerQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnswerQuiz(this.quizId);
}

class _AnswerQuiz extends State<AnswerQuiz> {
  final String quizId;
//  _AnswerQuiz(this.quizId);
  final answerController = TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  String val = "";
  String ch1 = "";
  String ch2 = "";
  String ch3 = "";
  String ch4 = "";

  _AnswerQuiz(this.quizId);

  fetchData(String qId) {
    databaseRef
        .child(qId)
        .child("question")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());

      setState(() {
        val = dataSnapshot.value.toString();
      });
    });
    databaseRef
        .child(qId)
        .child("choice1")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());

      setState(() {
        ch1 = dataSnapshot.value.toString();
      });
    });
    databaseRef
        .child(qId)
        .child("choice2")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());

      setState(() {
        ch2 = dataSnapshot.value.toString();
      });
    });
    databaseRef
        .child(qId)
        .child("choice3")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());

      setState(() {
        ch3 = dataSnapshot.value.toString();
      });
    });
    databaseRef
        .child(qId)
        .child("choice4")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());

      setState(() {
        ch4 = dataSnapshot.value.toString();
      });
    });
    String choices = "\n1. "+ ch1 +"\n2. "+ ch2+"\n3. " + ch3 + "\n4. " +ch4;
    return val+"\n"+ choices;
  }
  Future<void> addAnswer(String pin, String ans) async {
    String? deviceId = await _getId();
    databaseRef.child(pin).child("Answers").set({deviceId: ans});
  }
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
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
            Text("Question : " + fetchData(quizId) + '\n'),
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
                  addAnswer(quizId, answerController.text);
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
