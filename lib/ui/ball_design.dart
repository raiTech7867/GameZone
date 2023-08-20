import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class BallDesign extends StatelessWidget {
  final x;
  final y;
  final bool gameHasStarted;

  const BallDesign(
      {required this.x, this.y, required this.gameHasStarted, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gameHasStarted ? Container(
      alignment: Alignment(x, y),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: 14,
        height: 14,
      ),
    )
        : Container(
      alignment: Alignment(x,y),
      child: AvatarGlow(
        endRadius: 60.0,
        child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,color: Colors.white
              ),
              width: 30,
              height: 30,
            ),
            radius: 7.0,
          ),
        ),
      ),
    );
  }
}
