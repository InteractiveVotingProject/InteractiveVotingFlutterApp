import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''),
      const Locale('fr', ''),
    ],
    home: Homepage(code: null),
  ));
}
