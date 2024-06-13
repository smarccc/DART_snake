import 'package:flutter/material.dart';
import 'loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading Examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(), // Initially load the loading screen
    );
  }
}
