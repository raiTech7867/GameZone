import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gamezone/constantnts/Direction.dart';
import 'package:gamezone/routes/app_routes_config.dart';
import 'package:gamezone/ui/BoxDesign.dart';
import 'package:gamezone/ui/FoodDesign.dart';
import 'package:gamezone/ui/SnakeDesign.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: MyAppRoutes().router.routeInformationParser,
      routeInformationProvider: MyAppRoutes().router.routeInformationProvider,
      routerDelegate: MyAppRoutes().router.routerDelegate,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int foodPosition = 200;
  List<int> snakePosition = [];
  SnakeDirection snakeDirection = SnakeDirection.Down;
  int score=0;
  bool isGameRunning=false;
 late Timer timer;
  bool isGameOver=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseSnake();

  }

  void initialiseSnake() {
    for (var i = 0; i < 3; i++) {
      snakePosition.add(i);
    }
  }

  void startGame() {
    isGameRunning=true;
    timer=Timer.periodic(Duration(milliseconds: 300), (timer) {
      moveSnake();
      gameOver();
    });
  }

  void moveSnake() {
    if (snakeDirection == SnakeDirection.Right) {
      if (snakePosition.last % 15 == 14) {
        snakePosition.add(snakePosition.last + 1 - 15);
      } else {
        snakePosition.add(snakePosition.last + 1);
      }
    } else if (snakeDirection == SnakeDirection.Left) {
      if (snakePosition.last % 15 == 0) {
        snakePosition.add(snakePosition.last - 1 + 15);
      } else {
        snakePosition.add(snakePosition.last - 1);
      }
    } else if (snakeDirection == SnakeDirection.Up) {
      if (snakePosition.last < 15) {
        snakePosition.add(snakePosition.last - 15 + 330);
      } else {
        snakePosition.add(snakePosition.last - 15);
      }
    } else if (snakeDirection == SnakeDirection.Down) {
      if (snakePosition.last > 314) {
        snakePosition.add(snakePosition.last + 15 - 330);
      } else {
        snakePosition.add(snakePosition.last + 15);
      }
    }
    if(snakePosition.last==foodPosition){
      onEatFood();
    }else{
      snakePosition.removeAt(0);
    }
    setState(() {});
  }

  void onEatFood(){
    score++;
    while(snakePosition.contains(foodPosition)){
      foodPosition=Random().nextInt(329);
    }
  }


  void gameOver(){
    List<int> dublicateSnakePosition=[];
    dublicateSnakePosition.addAll(snakePosition);
    dublicateSnakePosition.remove(snakePosition.last);
    if(dublicateSnakePosition.contains(snakePosition.last)){
      Vibrate.feedback(FeedbackType.heavy);
      print("Game Over");
      timer.cancel();
      isGameOver=true;
      setState(() {});
    }
  }

  void restartGame(){
    isGameOver=false;
    score=0;
    snakePosition=[];
    initialiseSnake();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (dragUpdateDetails) {
        if (dragUpdateDetails.delta.dy > 0) {
          print("Downward");
          snakeDirection = SnakeDirection.Down;
        } else {
          print("Upward");
          snakeDirection = SnakeDirection.Up;
        }
        setState(() {});
      },
      onHorizontalDragUpdate: (dragUpdateDetails) {
        if (dragUpdateDetails.delta.dx > 0) {
          print("Right");
          snakeDirection = SnakeDirection.Right;
        } else {
          print("Left");
          snakeDirection = SnakeDirection.Left;
        }
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 330,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 15,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      if (index == foodPosition) {
                        return FoodDesign();
                      } else if (snakePosition.contains(index)) {
                        return SnakeDesign();
                      } else {
                        return BoxDesign(index: index);
                      }
                    })),
            Text("Score:$score",
            style: const TextStyle(color: Colors.white,
            fontSize: 18,
              fontWeight: FontWeight.w500
            ),
            ),
            isGameRunning?const SizedBox():ElevatedButton(
                onPressed: () {
                  startGame();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("Statrt Game",
                    style: TextStyle(color: Colors.black))),
            isGameOver?ElevatedButton(
                onPressed: () {
                  restartGame();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("Retry",
                    style: TextStyle(color: Colors.black))):const SizedBox()
          ],
        ),
      ),
    );
  }
}
