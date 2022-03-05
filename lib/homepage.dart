import 'package:flutter/material.dart';
import 'package:tic_tac_toe/theme/colors.dart';

import 'utils/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String x = 'X';
  bool gameOver = false;
  Game g = Game();
  int turn = 0;
  String result = '';
  List<int> score = [0, 0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    g.board = Game.initBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Its $x turn'.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 58,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: boardW,
            height: boardW,
            child: GridView.count(
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: Game.boardL ~/ 3,
              children: List.generate(Game.boardL, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (g.board[index] == '') {
                            setState(() {
                              g.board[index] = x;
                            });

                            turn++;
                            gameOver = g.winnerCheck(x, index, score, 3);
                            if (gameOver) {
                              result = '$x is the winner';
                            }

                            if (x == 'X')
                              x = 'O';
                            else
                              x = 'X';
                          }
                        },
                  child: Container(
                    width: Game.boardS,
                    height: Game.boardS,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        g.board[index],
                        style: TextStyle(
                          fontSize: 64,
                          color:
                              g.board[index] == 'X' ? Colors.blue : Colors.pink,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 25),
          Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: 50),
          ),
          SizedBox(height: 25),
          ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  g.board = Game.initBoard();
                  x = 'X';
                  gameOver = false;
                  turn = 0;
                  result = '';
                  score = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: Icon(Icons.replay),
              label: Text(
                'Replay',
              ),
              style: ElevatedButton.styleFrom(primary: accentColor)),
        ],
      ),
    );
  }
}
