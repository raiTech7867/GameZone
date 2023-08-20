import 'package:flutter/material.dart';

class BrickDesign extends StatelessWidget {

  final x;
  final y;
  final brickWidth;
  final thisIsEmpty;
  const BrickDesign({this.x,this.y,this.brickWidth,this.thisIsEmpty,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2*x+brickWidth)/(2-brickWidth),y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisIsEmpty?Colors.deepPurple[300]:Colors.pink[300],
          height: 20,
          width: MediaQuery.of(context).size.width*brickWidth/2
          ,
        ),
      ),
    );
  }
}
