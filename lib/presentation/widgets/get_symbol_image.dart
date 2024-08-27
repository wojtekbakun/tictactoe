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
            : currentPlayer == 'Super X'
                ? Image.asset(MyConsts.superXBubblePath)
                : currentPlayer == 'O'
                    ? Image.asset(MyConsts.oBubblePath)
                    : currentPlayer == 'Super O'
                        ? Image.asset(MyConsts.superOBubblePath)
                        : Image.asset(MyConsts.bubblePath);
  }
}
