import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:interactive_voting_flutter_app/ReadCode.dart';
import 'package:open_file/open_file.dart';

class History extends StatefulWidget {
  //final String quizId;
  const History({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _History();
}

class _History extends State<History> {
  final answerController = TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

  String val = "";
  String createdDate = "";
  String qId = "";

  Future<void> fetchHis() async {
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
          val += (key.toString() + ':' + values.toString() + '\n\n');
        });
      });
    });
    //return val + "\n";
  }

  Future<void> delAnswers() async {
    String? deviceId = await _getId();

    databaseRef
        .child(deviceId.toString())
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value);
      print(dataSnapshot.key);
      dataSnapshot.value.forEach((key, values) {
        print(key.toString());
        setState(() {
          qId = key.toString();
          databaseRef
              .child(qId)
              .child("creationDate")
              .once()
              .then((DataSnapshot dataSnapshot) {
            print(dataSnapshot.value.toString());
            setState(() {
              createdDate = dataSnapshot.value.toString();
              //print(createdDate);
              DateTime crDate = DateTime.parse(createdDate);
              //print('date is :'+ crDate.toString());

              DateTime currDate = DateTime.now();
              DateTime dateAfterTwoYr = crDate.add(Duration(days: 730));

              if (currDate.isAfter(dateAfterTwoYr)) {
                //databaseRef.child(qId).remove();
                databaseRef.child(deviceId.toString()).child(qId).remove();
              }
            });
          });
        });
      });
    });
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

  Future<String> _getDirPath() async {
    //final dir = await getApplicationDocumentsDirectory();
    final dir = await getExternalStorageDirectory();
    print(dir!.path);
    return dir.path;
  }

  void downloadFile(String val) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(now);

    final _dirPath = await _getDirPath();
    String historyFileName = "${_dirPath}/history_export_${formattedDate}.txt";
    print("historyFileName:" + historyFileName);
    final _myFile = File(historyFileName);
    // If data.txt doesn't exist, it will be created automatically
    // await _myFile.writeAsString(val);
    _myFile.writeAsStringSync(val);
    OpenFile.open(historyFileName);
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
            Text(
              "History for previously answered question(s) on this device: " +
                  '\n\n' +
                  fetchHis().toString().substring(0, 0),
              textAlign: TextAlign.left,
            ),
            if (val != "")
              Container(
                child: Text(
                  '\n\n' + val + '\n',
                  textAlign: TextAlign.left,
                ),
              ),
            if (val == "")
              Container(
                child: Text(
                    'The device has not been used to answer questions earlier.\n\n' +
                        'The previous participation is more than 2 years old and hence removed\n'),
              ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  // fetchHis();
                  downloadFile(val);
                },
                child: const Text('Download History'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                child: Text(
                  'Visit Quiz with Pin',
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
              child: ElevatedButton(
                onPressed: () {
                  delAnswers();
                  fetchHis();
                },
                child: const Text('Clean Up Data more than 2 years'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
