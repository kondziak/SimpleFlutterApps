import 'package:flutter/material.dart';
import './SIForm.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Calculator',
      home: SIForm(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigo,
        brightness: Brightness.dark,
      ),
    )
  );
}

