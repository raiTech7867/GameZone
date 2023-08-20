import 'package:flutter/material.dart';
import 'package:gamezone/routes/app_routes_constants.dart';
import 'package:go_router/go_router.dart';
class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:[ Container(
          child: const Center(
            child: Text("Category"),
          ),
        ),
          ElevatedButton(onPressed: (){
            GoRouter.of(context).pushNamed(MyAppRouteConstants.snakeGameRouteName);
            print("Snake Game Button Clicked");
          },child:Text("Snake Game"),),
          // ElevatedButton(onPressed: (){
          //   GoRouter.of(context).pushNamed(MyAppRouteConstants.pongGameRouteName);
          // },child:Text("Pong Game"),),
          ElevatedButton(onPressed: (){
            GoRouter.of(context).pushNamed(MyAppRouteConstants.tictacToeGameRouteName);
          },child:Text("TicTacToe Game"),),
          // ElevatedButton(onPressed: (){
          //   GoRouter.of(context).pushNamed(MyAppRouteConstants.flappyBirdGameRouteName);
          // },child:Text("Flappy Bird Game"),)
        ]
      ),

    );
  }
}
