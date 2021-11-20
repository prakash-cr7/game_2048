import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_2048/cell.dart';
import 'package:game_2048/game.dart';

class Grid extends ConsumerWidget {
  const Grid({Key? key}) : super(key: key);

  //Create cells inside the grid
  List<Cell> createCells(Game game) {
    final List<Cell> cells = <Cell>[];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        cells.add(Cell(
          data: game.gameData[i][j],
          key: ValueKey<int>(i * 4 + j),
        ));
      }
    }
    return cells;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 2.5,
      width: height / 2.5,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: Colors.grey[700] ?? Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: IgnorePointer(
        child: GridView.count(
          crossAxisCount: 4,
          children: createCells(game),
        ),
      ),
    );
  }
}
