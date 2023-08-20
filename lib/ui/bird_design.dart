import 'package:flutter/material.dart';
class BirdDesign extends StatelessWidget {
  final birdY;
  final double birdWidth;
  final double birdHeight;
  const BirdDesign({this.birdY,required this.birdWidth,required this.birdHeight,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,(2*birdY+birdHeight)/(2-birdHeight)),
      child: Image.asset('lib/images/birds.png',width:MediaQuery.of(context).size.height*birdWidth/2,
        height:MediaQuery.of(context).size.height*3/4*birdWidth/2,
        fit: BoxFit.fill
      ),
    );
  }
}
