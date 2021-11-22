import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_2048/constants.dart';
import 'package:game_2048/game_viewmodel.dart';
import 'package:game_2048/grid.dart';
import 'package:game_2048/score.dart';
import 'package:swipe/swipe.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '2048 Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return Swipe(
      verticalMaxWidthThreshold: 30,
      verticalMinDisplacement: 10,
      verticalMinVelocity: 40,
      horizontalMaxHeightThreshold: 30,
      horizontalMinDisplacement: 30,
      horizontalMinVelocity: 40,
      onSwipeUp: () {
        game.moveUp();
      },
      onSwipeDown: () {
        game.moveDown();
      },
      onSwipeLeft: () {
        game.moveLeft();
      },
      onSwipeRight: () {
        game.moveRight();
      },
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.keyW) ||
              event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            game.moveUp();
          } else if (event.isKeyPressed(LogicalKeyboardKey.keyS) ||
              event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            game.moveDown();
          } else if (event.isKeyPressed(LogicalKeyboardKey.keyA) ||
              event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            game.moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.keyD) ||
              event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            game.moveRight();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '2048 Game',
              style: ts.copyWith(fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Score(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                const Grid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
