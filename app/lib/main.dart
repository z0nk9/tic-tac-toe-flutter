import 'dart:developer';
import 'dart:ffi' hide Size;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.dark(primary: Color.fromRGBO(255, 0, 0, 1)),
      ),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<List<Move>> _board = [
    [Move.empty, Move.empty, Move.empty],
    [Move.empty, Move.empty, Move.empty],
    [Move.empty, Move.empty, Move.empty],
  ];
  Move _turn = Move.x;
  String _textDisplay = "";
  bool _retryVisible = false;

  void _setSquareValue(int x, int y, Move desiredValue) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _board[x][y] = desiredValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          spacing: 20,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text(
                _textDisplay,
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [_boardTile(0, 0), _boardTile(0, 1), _boardTile(0, 2)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [_boardTile(1, 0), _boardTile(1, 1), _boardTile(1, 2)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [_boardTile(2, 0), _boardTile(2, 1), _boardTile(2, 2)],
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: _retryVisible,
                child: ElevatedButton(
                  onPressed: _clearBoard,
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary)),
                  child: Text("Retry", style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boardTile(int x, int y) {
    return ElevatedButton(
      onPressed: () {
        if (_textDisplay == "") {
          if (_board[x][y] == Move.empty) {
            if (_turn == Move.o) {
              _turn = Move.x;
            } else {
              _turn = Move.o;
            }
            _setSquareValue(x, y, _turn);
          }
          _checkWinner();
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.square(150),
        backgroundColor: Color.fromRGBO(55, 55, 55, .75),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(_board[x][y].display, style: TextStyle(fontSize: 80)),
    );
  }

  void _checkWinner() {
    setState(() {
      List<Move> three = [];
      //column checking
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          three.add(_board[i][j]);
        }
        if (three.every((move) => move == Move.x)) {
          _textDisplay = "Player X wins!!";
          _retryVisible = true;
        }
        if (three.every((move) => move == Move.o)) {
          _textDisplay = "Player O wins!!";
          _retryVisible = true;
        }
        three.clear();
      }
      //row checking
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j < 3; j++) {
          three.add(_board[j][i]);
        }
        if (three.every((move) => move == Move.x)) {
          _textDisplay = "Player X wins!!";
          _retryVisible = true;
        }
        if (three.every((move) => move == Move.o)) {
          _textDisplay = "Player O wins!!";
          _retryVisible = true;
        }
        three.clear();
      }

      //diagonal checking
      three.add(_board[0][0]);
      three.add(_board[1][1]);
      three.add(_board[2][2]);
      if (three.every((move) => move == Move.x)) {
        _textDisplay = "Player X wins!!";
        _retryVisible = true;
      }
      if (three.every((move) => move == Move.o)) {
        _textDisplay = "Player O wins!!";
        _retryVisible = true;
      }
      three.clear();

      three.add(_board[0][2]);
      three.add(_board[1][1]);
      three.add(_board[2][0]);
      if (three.every((move) => move == Move.x)) {
        _textDisplay = "Player X wins!!";
        _retryVisible = true;
      }
      if (three.every((move) => move == Move.o)) {
        _textDisplay = "Player O wins!!";
        _retryVisible = true;
      }
      three.clear();
    });
    bool _emptySpotted = false;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; i < 3; i++) {
        if (_board[i][j] == Move.empty) {
          _emptySpotted = true;
        }
      }
    }
    if (_emptySpotted == false) {
      _textDisplay = "It's a draw!";
      _retryVisible = true;
    }
  }

  void _clearBoard() {
    setState(() {
      for (var i = 0; i < _board.length; i++) {
        _board[i].fillRange(0, _board[i].length, Move.empty);
      }
      _textDisplay = "";
      _retryVisible = false;
    });
  }
}

enum Move {
  empty(""),
  x("X"),
  o("O");

  final String display;
  const Move(this.display);
}
