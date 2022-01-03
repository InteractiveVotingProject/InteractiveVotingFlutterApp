import 'package:flutter/material.dart';
import 'package:interactive_voting_flutter_app/Homepage.dart';
import 'QRReader.dart';

class ReadCode extends StatelessWidget {
  const ReadCode({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QRReader()),
                  );
                },
                child: const Text('Use QR Reader'),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Enter code manually', textAlign: TextAlign.left),
                  TextField(
                    decoration: InputDecoration(hintText: 'Optional'),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                child: const Text('Generate'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
