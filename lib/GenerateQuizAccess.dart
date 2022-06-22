import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:interactive_voting_flutter_app/HomepageAccess.dart';
import 'package:interactive_voting_flutter_app/ShowChartAccess.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';
import 'ShowChart.dart';

Random random = new Random();
String randomNumber = random.nextInt(999999).toString();

class GenerateQuizAccess extends StatelessWidget {
  final String codeId;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  GenerateQuizAccess({Key? key, required this.codeId}) : super(key: key);
  Future<bool> _onWillPop(context) async {
    return (await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowChart(codeId: codeId)),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomepageAccess()),
          );
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Quiz Generation",
                  style: TextStyle(fontSize: 30.0)),
            ),
            body: Center(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Code is ' + codeId,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 30.0)),
                    ],
                  ),
                ),
                Container(
                    child: QrImage(
                  data: codeId as String,
                  version: QrVersions.auto,
                  size: 320,
                )),
                Container(
                  margin: EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShowChartAccess(codeId: codeId)),
                      );
                    },
                    child: const Text('Show Stats',
                        style: TextStyle(fontSize: 30.0)),
                  ),
                ),
              ]),
            )));
  }
}
