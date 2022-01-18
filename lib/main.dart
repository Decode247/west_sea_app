import 'package:flutter/material.dart';
import 'package:west_sea_app/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'West Sea App',
      home: HomePage(),
    );
  }
}
