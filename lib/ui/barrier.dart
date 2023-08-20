import 'package:flutter/material.dart';
class MyBarrier extends StatelessWidget {

  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarier;


  const MyBarrier({this.barrierWidth,this.barrierHeight,required this.isThisBottomBarier,Key? key, this.barrierX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2*barrierX+barrierWidth)/(2-barrierWidth),
          isThisBottomBarier?1:-1
      ),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width*barrierWidth/2,
        height: MediaQuery.of(context).size.height*3/4*barrierHeight/2,
      ),
    );
  }
}
