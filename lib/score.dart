import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_2048/constants.dart';
import 'package:game_2048/game.dart';

class Score extends ConsumerWidget {
  const Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: kIsWeb ? width * 0.25 : width * 0.8,
      height: 55,
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
      child: Center(
        child: Text('Score: ${game.score}', style: ts),
      ),
    );
  }
}
