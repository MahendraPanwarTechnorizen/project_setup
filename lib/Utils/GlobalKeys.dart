import 'package:flutter/material.dart';
import 'package:project_setup/Model/todoList.dart';

class MyGlobalKeys{
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
}
Future<List<TodoList>>? futureTodos;