class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';
}

class Game {
  static const boardL = 9;
  static const boardS = 100.0;

  List board = [];

  static List initBoard() => List.generate(boardL, (index) => Player.empty);

  bool winnerCheck(String player, int index, List<int> score, int gridSize) {
    int row = index ~/ 3;
    int col = index ~/ 3;
    int scorep = player == 'X' ? 1 : -1;
    score[row] += scorep;
    score[gridSize + col] += scorep;

    if (row == col) score[2 * gridSize] += scorep;
    if (gridSize - 1 - col == row) score[2 * gridSize + 1] += scorep;

    if (score.contains(3) || score.contains(-3)) {
      return true;
    }

    return false;
  }
}
