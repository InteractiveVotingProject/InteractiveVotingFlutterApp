import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

Random random = new Random();
String randomNumber = random.nextInt(999999).toString();

class GenerateQuiz extends StatelessWidget {
<<<<<<< HEAD
  final String codeId;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  GenerateQuiz({Key? key, required this.codeId}) : super(key: key);
=======
  const GenerateQuiz({Key? key, this.pin}) : super(key: key);
  final String? pin;
>>>>>>> UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz Generation"),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
<<<<<<< HEAD
                  Text('Code is ' + codeId, textAlign: TextAlign.left),
=======
                  Text('Code is ${pin}', textAlign: TextAlign.left),
>>>>>>> UI
                ],
              ),
            ),
            Container(
                child: QrImage(
              data: pin as String,
              version: QrVersions.auto,
              size: 320,
            )),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  // databaseRef
                  //     .child(codeId)
                  //     .child("revealAnswer")
                  //     .once()
                  //     .then((DataSnapshot dataSnapshot) {
                  //   print(dataSnapshot.value.toString());

                  //   setState(() {
                  //     val = dataSnapshot.value.toString();
                  //   });
                  databaseRef.child(codeId).update({"revealAnswer": true});

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const GenerateQuiz()),
                  // );
                },
                child: const Text('Reveal Answers'),
              ),
            ),
          ]),
        ));
  }
}
