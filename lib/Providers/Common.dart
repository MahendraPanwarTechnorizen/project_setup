
import 'package:flutter/material.dart';
import 'package:project_setup/Model/todoList.dart';
import 'package:project_setup/Services/SqliteServices/todo_db.dart';

class MyProvider extends ChangeNotifier {
  int mycount = 0;

  int get count => mycount;
  TextEditingController controller =TextEditingController();


  increment() {
    mycount++;
    notifyListeners();
  }

  Future<List<TodoList>>? futureTodos;
  final todoDB = TodoDB();

  void fetchTodos() {
    futureTodos = todoDB.fetchAll();
    notifyListeners();
  }

  submit(title,context,id)async{
    print("id-------${id}   ,  ${title}");

    await todoDB.update(id:id??0,title: title
        .toString());
    fetchTodos();
    print("futureTodos-------${futureTodos}");
    // Navigator.pop(context);
    notifyListeners();
  }
  delete(id,context) async {
    await todoDB.delete(id);
    fetchTodos();
    // Navigator.pop(context);
    notifyListeners();
  }
}
