import 'package:flutter/material.dart';
import 'package:tictactoe/core/consts/consts.dart';

class SymbolImage extends StatelessWidget {
  final String currentPlayer;
  const SymbolImage({super.key, required this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    return currentPlayer == ''
        ? Image.asset(MyConsts.bubblePath)
        : currentPlayer == 'X'
            ? Image.asset(MyConsts.xBubblePath)
            : Image.asset(MyConsts.oBubblePath);
  }
}
