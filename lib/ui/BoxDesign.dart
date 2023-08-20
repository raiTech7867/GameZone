import 'package:flutter/material.dart';
class BoxDesign extends StatelessWidget {
 final int index;
  BoxDesign({required  this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
       color: Colors.black,
       borderRadius: BorderRadius.circular(5)
     ),
    );
  }
}
