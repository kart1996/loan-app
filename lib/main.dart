import 'package:flutter/material.dart';
import 'screens/first_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bhgala',
      home: FirstPage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}
