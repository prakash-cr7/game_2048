import 'package:flutter/material.dart';
import 'package:game_2048/ui/constants.dart';

// ignore: must_be_immutable
class Cell extends StatelessWidget {
  int? data;
  Cell({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 10,
      width: height / 10,
      decoration: BoxDecoration(
          color: Colors.grey[800],
          border: Border.all(
            color: Colors.grey[700] ?? Colors.grey,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2.5,
            )
          ]),
      child: Center(
        child: Text(
          data == null ? '' : data.toString(),
          style: ts
        ),
      ),
    );
  }
}
