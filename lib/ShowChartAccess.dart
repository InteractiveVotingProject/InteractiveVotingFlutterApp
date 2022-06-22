import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:interactive_voting_flutter_app/CreateQuiz.dart';
import 'package:pie_chart/pie_chart.dart';

class ShowChartAccess extends StatefulWidget {
  final String codeId;

  const ShowChartAccess({Key? key, required this.codeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowChartAccess(this.codeId);
}

class _ShowChartAccess extends State<ShowChartAccess> {
  final String codeId;
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

  _ShowChartAccess(this.codeId);

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
        .child("correctAnswer")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value.toString());
      setState(() {
        cans = dataSnapshot.value.toString();
      });
    });

    return val + "\n";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poll ${codeId}', style: TextStyle(fontSize: 25.0)),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
            ),
            Text("Question : " + fetchQuestion(codeId),
                style: TextStyle(fontSize: 25.0)),
            Text(
                "Choices : " +
                    ch1 +
                    ';' +
                    ch2 +
                    ';' +
                    ch3 +
                    ';' +
                    ch4 +
                    ';' +
                    '\n',
                style: TextStyle(fontSize: 25.0)),
            Text("Correct Annwer(s) : " + cans + '\n',
                style: TextStyle(fontSize: 25.0)),
            Text("The polls are : " + fetchAnswers(codeId),
                style: TextStyle(fontSize: 25.0)),
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[])),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: PieChart(
                dataMap: dataMap,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey[50]!,
                colorList: colorList,
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  databaseRef.child(codeId).update({"revealAnswer": true});
                },
                child: const Text('Reveal Answer',
                    style: TextStyle(fontSize: 25.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                child: Text(
                  "Launch a quiz",
                  style: TextStyle(fontSize: 25.0),
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
          ],
        ),
      ),
    );
  }
}
