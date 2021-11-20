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

  void startGame() {
    isGameOver = false;
    score = 0;
    addRandomTile();
    addRandomTile();
    notifyListeners();
  }

  void addRandomTile() {
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
      notifyListeners();
    }
  }

  void transposeGrid() {
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

  void reverseMatrix() {
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

  void compress() {
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

  void combine() {
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
    compress();
    combine();
    compress();
    addRandomTile();
    notifyListeners();
  }

  void moveRight() {
    reverseMatrix();
    compress();
    combine();
    compress();
    reverseMatrix();
    addRandomTile();
    notifyListeners();
  }

  void moveUp() {
    transposeGrid();
    compress();
    combine();
    compress();
    transposeGrid();
    addRandomTile();
    notifyListeners();
  }

  void moveDown() {
    transposeGrid();
    reverseMatrix();
    compress();
    combine();
    compress();
    reverseMatrix();
    transposeGrid();
    addRandomTile();
    notifyListeners();
  }

  void gameOver() {
    bool isEmptyExists = false;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (gameData[i][j] == null) {
          isEmptyExists = true;
        }
      }
    }
    if (!isEmptyExists && !_horizontalMoveExists() && !_verticalMoveExists()) {
      isGameOver = true;
      print(isGameOver);
      notifyListeners();
    } else {
      isGameOver = false;
      notifyListeners();
    }
  }

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
