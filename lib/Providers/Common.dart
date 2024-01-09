import 'package:flutter/material.dart';
import 'package:project_setup/Model/todoList.dart';
import 'package:project_setup/Services/SqliteServices/todo_db.dart';
import 'package:project_setup/Utils/GlobalKeys.dart';

class MyProvider extends ChangeNotifier {
  int mycount = 0;

  int get count => mycount;
  TextEditingController controller = TextEditingController();

  increment() {
    mycount++;
    notifyListeners();
  }


  final todoDB = TodoDB();

  void fetchTodos() {
    futureTodos = todoDB.fetchAll();
    notifyListeners();
  }

  submitOnUpdate(title, context, id) async {
    controller.text = title;
    notifyListeners();
    print("id-------${id}   ,  ${title}");
    await todoDB.update(id: id ?? 0, title: title.toString());
    fetchTodos();
    print("futureTodos-------${futureTodos}");
    Navigator.pop(context);
    controller.text = '';
    notifyListeners();
  }
  submitOnCreate(title, context, ) async {
    controller.text = title;
    notifyListeners();
    print("id-------   ,  ${title}");
    int i = await todoDB.create(
      title: title.toString(),image:"https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY");
    fetchTodos();
    Navigator.of(context).pop();
    controller.text = '';
    notifyListeners();
  }

  delete(id, context) async {
    await todoDB.delete(id);
    fetchTodos();
    // Navigator.pop(context);
    notifyListeners();
  }
}
