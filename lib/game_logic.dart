import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameProvider = ChangeNotifierProvider<Game>(
  (ref) => Game(),
);

class Tuple {
  final int a;
  final int b;

  Tuple(this.a, this.b);
}

class Game extends ChangeNotifier {
  bool isGameOver = false;
  int score = 0;
  Random random = Random();
  List<List<int?>> gameData = [
    [null, null, 2, null],
    [null, null, null, null],
    [null, 4, null, null],
    [null, null, null, null],
  ];

  void restartGame() {
    isGameOver = false;
    score = 0;
    gameData = [
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ];
    _addRandomTile();
    _addRandomTile();
    notifyListeners();
  }

  void _addRandomTile() {
    if (isGameOver) return;
    List<Tuple> _index = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (gameData[i][j] == null) {
          _index.add(Tuple(i, j));
        }
      }
    }
    if (_index.isNotEmpty) {
      int randomIndex = random.nextInt(_index.length);
      gameData[_index[randomIndex].a][_index[randomIndex].b] =
          random.nextInt(10) < 8 ? 2 : 4;

      //check at the end of adding a random tile if the game is over
      isGameOver = gameOver();
      notifyListeners();
    }
  }

  void _transposeGrid() {
    List<List<int?>> _gameData = [
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        _gameData[i][j] = gameData[j][i];
      }
    }
    gameData = _gameData;
    notifyListeners();
  }

  // flip the grid horizontally
  void _reverseMatrix() {
    List<List<int?>> _gameData = [
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        _gameData[i][j] = gameData[i][3 - j];
      }
    }
    gameData = _gameData;
    notifyListeners();
  }

  // move all tiles to the left
  void _compress() {
    List<List<int?>> _gameData = [
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ];
    for (int i = 0; i < 4; i++) {
      int _count = 0;
      for (int j = 0; j < 4; j++) {
        if (gameData[i][j] != null) {
          _gameData[i][_count] = gameData[i][j];
          _count += 1;
        }
      }
    }
    gameData = _gameData;
    notifyListeners();
  }

  // combine all tiles with the same value
  void _combine() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        if (gameData[i][j] != null && gameData[i][j] == gameData[i][j + 1]) {
          gameData[i][j] = (gameData[i][j]! * 2);
          gameData[i][j + 1] = null;
          score += gameData[i][j] ?? 0;
        }
      }
    }
    notifyListeners();
  }

  void moveLeft() {
    _compress();
    _combine();
    _compress();
    _addRandomTile();
    notifyListeners();
  }

  void moveRight() {
    _reverseMatrix();
    _compress();
    _combine();
    _compress();
    _reverseMatrix();
    _addRandomTile();
    notifyListeners();
  }

  void moveUp() {
    _transposeGrid();
    _compress();
    _combine();
    _compress();
    _transposeGrid();
    _addRandomTile();
    notifyListeners();
  }

  void moveDown() {
    _transposeGrid();
    _reverseMatrix();
    _compress();
    _combine();
    _compress();
    _reverseMatrix();
    _transposeGrid();
    _addRandomTile();
    notifyListeners();
  }

  bool gameOver() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (gameData[i][j] == null) return false;
      }
    }
    if (!_horizontalMoveExists() && !_verticalMoveExists()) {
      return true;
    }
    return false;
  }

  // check if there is any horizontal move left
  bool _horizontalMoveExists() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        if (gameData[i][j] != null && gameData[i][j] == gameData[i][j + 1]) {
          return true;
        }
      }
    }
    return false;
  }

  // check if there is any vertical move left
  bool _verticalMoveExists() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 4; j++) {
        if (gameData[i][j] != null && gameData[i][j] == gameData[i + 1][j]) {
          return true;
        }
      }
    }
    return false;
  }
}
