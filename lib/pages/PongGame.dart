import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamezone/constantnts/Direction.dart';
import 'package:gamezone/pages/score_screen.dart';
import 'package:gamezone/ui/Brick_design.dart';
import 'package:gamezone/ui/ball_design.dart';
import 'package:gamezone/pages/pong_cover_screen.dart';

class PongGame extends StatefulWidget {
  const PongGame({Key? key}) : super(key: key);

  @override
  State<PongGame> createState() => _PongGameState();
}

class _PongGameState extends State<PongGame> {
  bool _gameStarted = false;
  double _ballx = 0;
  double _bally = 0;
  double _playerx = -0.2;
  var ballyDirection = BallDirection.Down;
  var ballxDirection = BallDirection.Left;
  double brickWidth = 0.4; //out of 2
  int playerScore=0;
  //enemy variable(top brick)
  double enemyX = -0.2;
  int enemyScor=0;

  void startGame() {
    _gameStarted = true;
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      //Update Direction
      updateDirection();
      //move ball
      moveBall();

      //move enemy
      moveEnemy();

      //check if player is dead
      if (isPlayerDead()) {
        enemyScor++;
        timer.cancel();
        _showDialog(false);
      }
      if (isEnemyDead()) {
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }
    });
  }

  bool isEnemyDead(){

    if(_bally<=-1){
      return true;
    }
    return false;
  }

  void moveEnemy(){
    setState(() {
      enemyX=_ballx;
    });
  }

  void _showDialog(bool enemyDied) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.purple,
            title: Center(
              child: Text(
                enemyDied?"Pink Win":"PURPLE WIN",
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
                    color: enemyDied?Colors.pink[100]:Colors.deepPurple[100],
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: enemyDied?Colors.pink[800]:Colors.deepPurple[800]),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      _gameStarted = false;
      _ballx = 0;
      _bally = 0;
      _playerx = -0.2;
      enemyX=-0.2;
    });
  }

  bool isPlayerDead() {
    if (_bally >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
//Update Vertical Direction
    if (_bally >= 0.9 &&
        _playerx + brickWidth >= _ballx &&
        _playerx <= _ballx) {
      ballyDirection = BallDirection.Up;
    } else if (_bally <= -0.9) {
      ballyDirection = BallDirection.Down;
    }
    //Update Horizontal Direction
    if (_ballx >= 1) {
      ballxDirection = BallDirection.Left;
    } else if (_ballx <= -1) {
      ballxDirection = BallDirection.Right;
    }
    setState(() {});
  }

  void moveBall() {
// Vertical movement
    setState(() {
      if (ballyDirection == BallDirection.Down) {
        _bally += 0.01;
      } else if (ballyDirection == BallDirection.Up) {
        _bally -= 0.01;
      }
      if (ballxDirection == BallDirection.Left) {
        _ballx -= 0.01;
      } else if (ballxDirection == BallDirection.Right) {
        _ballx += 0.01;
      }
    });
    // Horizontal movement


  }

  void moveLeft() {
    setState(() {
      if(!(_playerx-0.1<=-1)){
        _playerx-=0.01;
      }
    });
  }

  void moveRight() {
    setState(() {
      if(!(_playerx+brickWidth>=1)){
        _playerx+=0.01;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (dragUpdateDetails) {
        if (dragUpdateDetails.delta.dx > 0) {
          moveRight();
      }else{
          moveLeft();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: Stack(
              children: [
                //tap to play
                PongCoverScreen(gameStarted: _gameStarted),
                //Score Screen
                ScoreScrren(gameHasStarted:_gameStarted,enemyScore: enemyScor,playerScore: playerScore),
                //top Brick
                BrickDesign(x: enemyX, y: -0.9, brickWidth: brickWidth,thisIsEmpty:true),

                //bottom Design
                BrickDesign(
                  x: _playerx,
                  y: 0.9,
                  brickWidth: brickWidth,
                    thisIsEmpty:false
                ),
                //Ball Design
                BallDesign(x: _ballx, y: _bally,gameHasStarted: _gameStarted),
                Container(
                  alignment: Alignment(_playerx, 0.9),
                  child: Container(
                    width: 2,
                    height: 20,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
