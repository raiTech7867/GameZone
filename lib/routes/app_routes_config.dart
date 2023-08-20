import 'package:flutter/material.dart';
import 'package:gamezone/main.dart';
import 'package:gamezone/pages/CategoryPage.dart';
import 'package:gamezone/pages/TicTacToe.dart';
import 'package:gamezone/pages/error_page.dart';
import 'package:gamezone/pages/flappy_bird.dart';
import 'package:go_router/go_router.dart';
import 'package:gamezone/pages/PongGame.dart';
import 'package:gamezone/routes/app_routes_constants.dart';

class MyAppRoutes{
  GoRouter router=GoRouter(
    routes: [
      GoRoute(name: MyAppRouteConstants.categoryRouteName,
      path: '/',
      pageBuilder: (context,state){
        return MaterialPage(child: CategoryPage());
      }
      ),
      GoRoute(name: MyAppRouteConstants.snakeGameRouteName,
          path: '/snakeGame',
          pageBuilder: (context,state){
            return const MaterialPage(child: MyHomePage());
          }
      ),
      GoRoute(name: MyAppRouteConstants.pongGameRouteName,
          path: '/pongGame',
          pageBuilder: (context,state){
            return MaterialPage(child: PongGame());
          }
      ),
      GoRoute(name: MyAppRouteConstants.tictacToeGameRouteName,
          path: '/ticTacToeGame',
          pageBuilder: (context,state){
            return MaterialPage(child: TicTacToe());
          }
      ),
      GoRoute(name: MyAppRouteConstants.flappyBirdGameRouteName,
          path: '/flappyBirdGame',
          pageBuilder: (context,state){
            return MaterialPage(child: FlappyBird());
          }
      )
    ],
    errorPageBuilder: (context,state){
      return MaterialPage(child: ErrorPage());
    }
  );

}