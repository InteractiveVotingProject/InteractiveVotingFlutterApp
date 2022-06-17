import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:pie_chart/pie_chart.dart';

class ShowChart extends StatefulWidget {
  final String codeId;

  const ShowChart({Key? key, required this.codeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShowChart(this.codeId);
}

class _ShowChart extends State<ShowChart> {
  final String codeId;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  Map<String, double> dataMap = <String, double>{};

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

  _ShowChart(this.codeId);

  fetchData(String qId) {
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

    var ans = [];
    databaseRef
        .child(qId)
        .child("answers")
        .once()
        .then((DataSnapshot dataSnapshot) {
      //print(dataSnapshot.value);
      //print(dataSnapshot.key);
      dataSnapshot.value.forEach((key, values) {
        print(values.toString());
        setState(() {
          //ans.update(key,values);
          ans.add(values.toString());

          print('The length' + ans.length.toString());

          //dataMap.update(key, values);
          //print(dataMap.values);
          // val = (key.toString() + ':' + values.toString());
          //print(val);
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

        // dataMap = counts.cast<String,double>();
        counts.forEach((k, v) {
          dataMap[k] = v + .0;
        });
        print("its dataMap for PIe chart");
        print(dataMap);
      });
    });

    return val + "\n";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poll ${codeId}'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
            ),
            Text("The polls are : " + fetchData(codeId) + '\n'),
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[])),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                  fetchData(codeId);
                },
                child: const Text('Refresh'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
