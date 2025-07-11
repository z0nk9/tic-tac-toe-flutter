import 'package:flutter/material.dart';

class MyGamePage extends StatefulWidget {
  const MyGamePage({super.key, required this.title, required this.isTwoPlayer});

  final String title;
  final bool isTwoPlayer;

  @override
  State<MyGamePage> createState() => _MyGamePageState();
}

class _MyGamePageState extends State<MyGamePage> {
  final List<List<Move>> _board = [
    [Move.empty, Move.empty, Move.empty],
    [Move.empty, Move.empty, Move.empty],
    [Move.empty, Move.empty, Move.empty],
  ];
  Move _turn = Move.o;
  String _textDisplay = "Player O's turn";
  bool _retryVisible = false;

  void _setSquareValue(int x, int y, Move desiredValue) {
    setState(() {
      _board[x][y] = desiredValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
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
                  onPressed: () {
                    _clearBoard();
                    _textDisplay = "Player ${_turn.display}'s turn";
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
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
        if (_textDisplay.contains("turn")) {
          if (_board[x][y] == Move.empty) {
            _setSquareValue(x, y, _turn);
            if (_turn == Move.o) {
              _turn = Move.x;
              _textDisplay = "Player X's turn";
            } else {
              _turn = Move.o;
              _textDisplay = "Player O's turn";
            }
          }
          _checkWinner();
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size.square((MediaQuery.sizeOf(context).shortestSide) / 4),
        backgroundColor: Color.fromRGBO(55, 55, 55, .75),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(_board[x][y].display, style: TextStyle(fontSize: 80)),
    );
  }

  void _checkWinner() {
    setState(() {
      List<List<Move>> threes = List.empty(growable: true);
      // rows
      for (var i = 0; i < 3; i++) {
        threes.add(_board[i]);
      }
      // columns
      for (var i = 0; i < 3; i++) {
        List<Move> column = List.empty(growable: true);
        for (var j = 0; j < 3; j++) {
          column.add(_board[i][j]);
        }
        threes.add(column);
      }
      // diagonals
      threes.add(List.empty(growable: true));
      threes.add(List.empty(growable: true));
      for (var i = 0; i < 3; i++) {
        threes[7].add(_board[i][i]);
      }

      threes[8].add(_board[0][2]);
      threes[8].add(_board[1][1]);
      threes[8].add(_board[2][0]);
      for (var i = 0; i < threes.length; i++) {
        if (threes[i].every((move) => move == Move.o)) {
          _textDisplay = "Player O wins!!";
          _retryVisible = true;
        }
        if (threes[i].every((move) => move == Move.x)) {
          _textDisplay = "Player X wins!!";
          _retryVisible = true;
        }
      }
      bool emptySpotted = false;
      for (var i = 0; i < _board.length; i++) {
        for (var j = 0; j < _board.length; j++) {
          if (_board[i][j] == Move.empty) {
            emptySpotted = true;
          }
        }
      }
      if (!emptySpotted) {
        _textDisplay = "It's a draw!";
        _retryVisible = true;
      }
    });
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

  void _compMove() {
    List<List<Move>> threes = List.empty(growable: true);
    // rows
    for (var i = 0; i < 3; i++) {
      threes.add(_board[i]);
    }
    // columns
    for (var i = 0; i < 3; i++) {
      List<Move> column = List.empty(growable: true);
      for (var j = 0; j < 3; j++) {
        column.add(_board[i][j]);
      }
      threes.add(column);
    }
    // diagonals
    threes.add(List.empty(growable: true));
    threes.add(List.empty(growable: true));
    for (var i = 0; i < 3; i++) {
      threes[7].add(_board[i][i]);
    }

    threes[8].add(_board[0][2]);
    threes[8].add(_board[1][1]);
    threes[8].add(_board[2][0]);
  }
}

enum Move {
  empty(""),
  x("X"),
  o("O");

  final String display;
  const Move(this.display);
}
