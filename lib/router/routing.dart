import 'package:api_todo/data/models/apitodo.dart';
import 'package:api_todo/presentation/screens/Home_Screen.dart';
import 'package:api_todo/presentation/screens/addupdatescreen.dart';
import 'package:flutter/material.dart';

const String addupdatescreen = '/secondScreen';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const MyHomePage());
      case addupdatescreen:

        final todo = settings.arguments as ApiTodo;
          return MaterialPageRoute(builder: (context) => AddUpdateScreen(todo: todo));
      default:
        return MaterialPageRoute(builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('ERROR'),
          ),
          body: const Center(child: Text('No Route Found')),
        ));
    }
  }
}
