import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:interactive_voting_flutter_app/ReadCode.dart';

class History extends StatefulWidget {
  //final String quizId;
  const History({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _History();
}

class _History extends State<History> {
  //final String quizId;
//  _AnswerQuiz(this.quizId);
  final answerController = TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  String val = "";


  // _History(this.quizId);

  Future<String> fetchHis() async {
    String? deviceId = await _getId();
   val = "";
    databaseRef
        .child(deviceId.toString())
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value);
      print(dataSnapshot.key);
      dataSnapshot.value.forEach((key, values) {
        print(values.toString());
        setState(() {
          val += (key.toString() + ':' + values.toString()+'\n\n');
          //print(val);
        });
      });
    });

    //String choices =
    //  "\n1. " + ch1 + "\n2. " + ch2 + "\n3. " + ch3 + "\n4. " + ch4;
    return val + "\n";
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
        title: Text('History'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
            ),
            Text("History participation for this device " + '\n'),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  fetchHis();
                },
                child: const Text('Check History'),
              ),
            ),
            Container(
              child: Text('Previously answered questions are,' + '\n\n' + val+'\n'),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: OutlinedButton(
                child: Text(
                  'Visit Quiz with Pin',
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
          ],
        ),
      ),
    );
  }
}
