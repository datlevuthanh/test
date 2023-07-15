import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeGame());
}

class TicTacToeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-tac-toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeBoard(),
    );
  }
}

class TicTacToeBoard extends StatefulWidget {
  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late List<List<String>> board;
  late bool isPlayer1Turn;

  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  // Khởi tạo bảng chơi và đặt lượt chơi ban đầu cho Player 1
  void initializeBoard() {
    board = List.generate(3, (_) => List.filled(3, ''));
    isPlayer1Turn = true;
  }

  // Xử lý sự kiện khi người chơi chọn một ô trên bảng
  void handleTap(int row, int col) {
    if (board[row][col] == '') {
      setState(() {
        // Đặt ký hiệu của người chơi hiện tại vào ô đó
        board[row][col] = isPlayer1Turn ? 'X' : 'O';
        // Chuyển lượt cho người chơi tiếp theo
        isPlayer1Turn = !isPlayer1Turn;
      });
    }
  }

  // Kiểm tra xem có người chơi nào đã thắng hay không
  String checkWinner() {
    // Kiểm tra các dòng
    for (int row = 0; row < 3; row++) {
      if (board[row][0] != '' &&
          board[row][0] == board[row][1] &&
          board[row][0] == board[row][2]) {
        return board[row][0];
      }
    }

    // Kiểm tra các cột
    for (int col = 0; col < 3; col++) {
      if (board[0][col] != '' &&
          board[0][col] == board[1][col] &&
          board[0][col] == board[2][col]) {
        return board[0][col];
      }
    }

    // Kiểm tra các đường chéo
    if (board[0][0] != '' &&
        board[0][0] == board[1][1] &&
        board[0][0] == board[2][2]) {
      return board[0][0];
    }
    if (board[0][2] != '' &&
        board[0][2] == board[1][1] &&
        board[0][2] == board[2][0]) {
      return board[0][2];
    }

    // Không có người chiến thắng
    return '';
  }

  // Xây dựng ô trên bảng chơi
  Widget buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => handleTap(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            board[row][col],
            style: TextStyle(fontSize: 48),
          ),
        ),
      ),
    );
  }

  // Xây dựng bảng chơi Tic-tac-toe
  Widget buildBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int row = 0; row < 3; row++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int col = 0; col < 3; col++)
                buildCell(row, col),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String winner = checkWinner();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-tac-toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (winner.isNotEmpty)
              Text(
                'Winner: $winner',
                style: TextStyle(fontSize: 24),
              ),
            buildBoard(),
            ElevatedButton(
              child: Text('Restart'),
              onPressed: () {
                setState(() {
                  initializeBoard();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
