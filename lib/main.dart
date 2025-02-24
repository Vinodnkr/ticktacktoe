import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  late List<String> board;
  late String currentPlayer;
  late String winner;
  late bool isDraw;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    board = List.generate(9, (_) => '');
    currentPlayer = 'X';
    winner = '';
    isDraw = false;
  }

  void _handleTap(int index) {
    if (board[index] != '' || winner != '') return; // Prevent overwriting a cell and ignore taps after game over

    setState(() {
      board[index] = currentPlayer;
      if (_checkWinner(currentPlayer)) {
        winner = currentPlayer;
      } else if (_checkDraw()) {
        isDraw = true;
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool _checkWinner(String player) {
    // Check rows, columns and diagonals for a win
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == player && board[i * 3 + 1] == player && board[i * 3 + 2] == player) {
        return true;
      }
      if (board[i] == player && board[i + 3] == player && board[i + 6] == player) {
        return true;
      }
    }
    if (board[0] == player && board[4] == player && board[8] == player) {
      return true;
    }
    if (board[2] == player && board[4] == player && board[6] == player) {
      return true;
    }
    return false;
  }

  bool _checkDraw() {
    return board.every((cell) => cell != '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
           MaterialButton(
             color: const Color.fromARGB(255, 192, 219, 160),
              padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0),
  ),
             elevation: 5,
            child: const Text('Restart Game', style: TextStyle(color:Color.fromARGB(255, 19, 123, 22), fontSize:28, fontWeight: FontWeight.bold)),
            
            onPressed: () {
              setState(() {
                _initializeGame();
              });
            },
          ),
          winner != ''
              ? Text('Winner: $winner', style: const TextStyle(fontSize: 30),)
              : isDraw
                  ? const Text('Draw', style: TextStyle(fontSize: 30))
                  : Text('Current Player: $currentPlayer', style: const TextStyle(fontSize: 30)),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GridTile(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: MaterialButton(
                      onPressed: () => _handleTap(index),
                      child: Text(board[index], style: const TextStyle(fontSize: 40)),
                    ),
                  ),
                );
              },
            ),
          ),
         
        ],
      ),
    );
  }
}

