import 'package:flutter/material.dart';

import 'constants.dart';
import 'game_viewmodel.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    Key? key,
    required this.height,
    required this.game,
  }) : super(key: key);

  final double height;
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 2.5,
      width: height / 2.5,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: lightBgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Game Over',
            style: ts.copyWith(fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Score: ${game.score}',
            style: ts.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black38)),
            onPressed: () {
              game.restartGame();
            },
            child: Text(
              'Play Again',
              style: ts.copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
