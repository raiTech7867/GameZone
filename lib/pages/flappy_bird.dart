import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamezone/ui/barrier.dart';
import 'package:gamezone/ui/bird_design.dart';

class FlappyBird extends StatefulWidget {
  const FlappyBird({Key? key}) : super(key: key);

  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBird> {
  static double _birdY = 0;
  double initialPos = _birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;
  //game Setting
  bool _gameHasStarted=false;
  double birdWidth=0.1;
  double birdHeight=0.1;

  //barrier variable
  static List<double>barrierx=[2,2+1.5];
  static double barrierWidth=0.5;//Out of 2
  List<List<double>> barrierHeight=[
    //out of 2, where 2 is the entire height of the screen
    //[topHeight,bottomHeight]
    [0.6,0.4],
    [0.4,0.6]
  ];

  void startGame() {
    _gameHasStarted=true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        _birdY = initialPos-height;
      });
      print(_birdY);
      // check if bird is dead
      if(birdIsDead()){
        timer.cancel();
        _showDialog();
      }
      moveMap();
      time+=0.01;
    });
  }
  void moveMap(){
    for(int i=0;i<barrierx.length;i++){
      //keep barrier moving
      setState(() {
        barrierx[i]-=0.005;
      });
      //if barrier exists the left part of the screen ,keep it looping
      if(barrierx[i]<-1.5){
        barrierx[i]+=3;
      }
    }
  }

  void jump(){
    time=0;
    initialPos=_birdY;
    setState(() {
    });
  }
  bool birdIsDead(){
    // check if the bird is hitting the top or the bottom of the screen
    if(_birdY<-1||_birdY>1){
      return true;
    }
    //hits barriers
    //Check if bird is within x coordiantes and y coordinates of barriers
    for(int i=0;i<barrierx.length;i++) {
      if (barrierx[i] <= birdWidth &&
          barrierx[i] + barrierWidth >= -birdWidth &&
          (_birdY <= -1 +  barrierHeight[i][0]||_birdY+birdHeight>=1-barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }
  void resetGame(){
    Navigator.pop(context);
    setState(() {
      _birdY=0;
      _gameHasStarted=false;
      time=0;
      initialPos=_birdY;
    });
  }
  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.purple,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color:Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:_gameHasStarted? jump:startGame,
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [BirdDesign(birdY: _birdY,
                    birdWidth: birdWidth,
                      birdHeight: birdHeight,
                    ),
                      Container(
                        alignment: Alignment(0,-0.5),
                        child: Text(_gameHasStarted?'':'T A P  T O  P L A Y',style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                      //Top barrier 0
                      MyBarrier(
                        barrierWidth: barrierWidth,
                      barrierX:barrierx[0],
                      barrierHeight: barrierHeight[0][0],
                      isThisBottomBarier: false,
                      ),
                      //Bottom barrier 0
                      MyBarrier(
                        barrierWidth: barrierWidth,
                        barrierX:barrierx[0],
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarier: true,
                      ),
                      //Top barrier 1
                      MyBarrier(
                        barrierWidth: barrierWidth,
                        barrierX:barrierx[1],
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarier: false,
                      ),
                      //Bottom barrier 1
                      MyBarrier(
                        barrierWidth: barrierWidth,
                        barrierX:barrierx[1],
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarier: true,
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              child: Container(
            color: Colors.brown,
          ))
        ],
      )),
    );
  }
}
