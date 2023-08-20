import 'package:flutter/material.dart';
class PongCoverScreen extends StatelessWidget {
  final bool gameStarted;
  PongCoverScreen({required this.gameStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,-0.2),
      child: Text(gameStarted?'':
        'T A P  To  P L A Y',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
