import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:pie_chart/pie_chart.dart';

class AnswerQuiz extends StatefulWidget {
  final String quizId;

  const AnswerQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnswerQuiz(this.quizId);
}

class _AnswerQuiz extends State<AnswerQuiz> {
  final String quizId;
  final answerController = TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  Map<String, double> dataMap = <String, double>{"No Answers Yet": 0};

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.lightBlueAccent,
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.deepPurpleAccent
  ];

  String val = "";
  String ch1 = "";
  String ch2 = "";
  String ch3 = "";
  String ch4 = "";
  String rans = "";
  String cans = "";

  _AnswerQuiz(this.quizId);

  fetchQuestion(String qId) {
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
    databaseRef
        .child(qId)
        .child("revealAnswer")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());
      setState(() {
        rans = dataSnapshot.value.toString();
      });
    });

    if (rans == 'true') {
      databaseRef
          .child(qId)
          .child("correctAnswer")
          .once()
          .then((DataSnapshot dataSnapshot) {
        print(dataSnapshot.value.toString());
        setState(() {
          cans = dataSnapshot.value.toString();
        });
      });
    }

    return val + "\n";
  }

  fetchAnswers(String qId) {
    var ans = [];
    databaseRef
        .child(qId)
        .child("answers")
        .once()
        .then((DataSnapshot dataSnapshot) {
      dataSnapshot.value.forEach((key, values) {
        print(values.toString());
        setState(() {
          ans.add(values.toString());
          print('The length' + ans.length.toString());
        });
        //int i = 1;
        var counts = new Map();

        ans.forEach((element) {
          if (!counts.containsKey(element)) {
            //i = 1.0;
            counts[element] = 1;
          } else {
            //i += 1;
            counts[element] += 1;
          }
        });
        dataMap.clear();
        counts.forEach((k, v) {
          dataMap[k] = v + .0;
        });
        print("its dataMap for PIe chart");
        print(dataMap);
      });
    });

    return "\n";
  }

  Future<void> addAnswer(String pin, String ans) async {
    String? deviceId = await _getId();
    databaseRef.child(pin).child("answers").child(deviceId.toString()).set(ans);
    // databaseRef.child(pin).child("answers").set({deviceId: ans});
    databaseRef.child(deviceId.toString()).child(pin.toString()).set("Q:" +
        val +
        ";Choice:" +
        ch1 +
        "," +
        ch2 +
        "," +
        ch3 +
        "," +
        ch4 +
        ";Sol:" +
        cans);
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

  //Checkbox implementation
  bool valueCb1 = false;
  bool valueCb2 = false;
  bool valueCb3 = false;
  bool valueCb4 = false;

  String getAnswers() {
    String ans = "";
    if (valueCb1) ans += "1;";
    if (valueCb2) ans += "2;";
    if (valueCb3) ans += "3;";
    if (valueCb4) ans += "4;";

    return ans;
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
            Text("Question : " + fetchQuestion(quizId) + '\n'),
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                          child: Text("1. " + ch1),
                          onPressed: null,
                        ),
                        Checkbox(
                          value: this.valueCb1,
                          onChanged: (bool? valueCb1) {
                            setState(() {
                              this.valueCb1 = valueCb1!;
                            });
                          },
                        ),
                        ElevatedButton(
                          child: Text("2. " + ch2),
                          onPressed: null,
                        ),
                        Checkbox(
                          value: this.valueCb2,
                          onChanged: (bool? valueCb2) {
                            setState(() {
                              this.valueCb2 = valueCb2!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                          child: Text("3. " + ch3),
                          onPressed: null,
                        ),
                        Checkbox(
                          value: this.valueCb3,
                          onChanged: (bool? valueCb3) {
                            setState(() {
                              this.valueCb3 = valueCb3!;
                            });
                          },
                        ),
                        ElevatedButton(
                          child: Text("4. " + ch4),
                          onPressed: null,
                        ),
                        Checkbox(
                          value: this.valueCb4,
                          onChanged: (bool? valueCb4) {
                            setState(() {
                              this.valueCb4 = valueCb4!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ])),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  addAnswer(quizId, getAnswers());
                  fetchAnswers(quizId);
                },
                child: const Text('Submit Answer'),
              ),
            ),
            Container(
              child: Text('The correct answer(s) : ' +
                  cans +
                  '\n' +
                  fetchAnswers(quizId)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey[50]!,
                colorList: colorList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
