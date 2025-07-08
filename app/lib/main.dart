
import 'package:app/start_page.dart';
import 'package:flutter/material.dart';
import 'game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(primary: Color.fromRGBO(255, 0, 0, 1)),
      ),
      home: MyStartPage(),
    );
  }
}
