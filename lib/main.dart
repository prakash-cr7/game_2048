import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_2048/game.dart';
import 'package:game_2048/grid.dart';

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
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 12) {
          print('right');
          game.moveRight();
        } else if (details.delta.dx < -12) {
          game.moveLeft();
          print('left');
        } else if (details.delta.dy > 12) {
          game.moveDown();
          print('down');
        } else if (details.delta.dy < -12) {
          game.moveUp();
          print('up');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('2048 Game'),
          centerTitle: true,
        ),
        body: const Center(
          child: Grid(),
        ),
      ),
    );
  }
}
