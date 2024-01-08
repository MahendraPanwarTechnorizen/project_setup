import 'package:project_setup/Model/todoList.dart';
import 'package:project_setup/Services/SqliteServices/dbServices.dart';
import 'package:project_setup/Utils/ImportFile.dart';

class TodoDB {
  final tableName = "todos";

  Future<void> createTable(Database database) async {
    // await database.execute(
        // """CREATE TABLE IF NOT EXISTS $tableName("id" INTEGER NOT NULL,"title" TEXT NOT NULL,"created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now')as int),"update_at" INTEGER,PRIMARY KEY("id" AUTOINCREMENT);)""");
    await database.execute("""
  CREATE TABLE IF NOT EXISTS $tableName (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    "updated_at" INTEGER,
    PRIMARY KEY ("id" AUTOINCREMENT)
  );
""");
  }
  Future<int> create({required String title})async{
    print("title------$title");
    final database = await DatabaseServices().database;
    return await database.rawInsert('''INSERT INTO $tableName (title,created_at) VALUES (?,?)''',[title,DateTime.now().millisecondsSinceEpoch]);
  }
  Future<List<TodoList>>fetchAll()async{
    final database=await DatabaseServices().database;
    final todos = await database.rawQuery('''SELECT * from $tableName''');
    print("todos---------$todos");
    print("todos---------${todos.map((todo) => TodoList.fromJson(todo)).toList()}");
    return todos.map((todo) => TodoList.fromJson(todo)).toList();
  }
  Future<TodoList>fetchById(int id)async{
    final database=await DatabaseServices().database;
    final todo = await database.rawQuery('''SELECT * from $tableName WHERE id= ?''',[id]);
    return TodoList.fromJson(todo.first);
  }                                                      
  Future<int> update({required int id , String? title})async{
    final database=await DatabaseServices().database;
    return await database.update(tableName, {
      if(title !=null) 'title':title,
      'updated_at':DateTime.now().millisecondsSinceEpoch,
    },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id]
    );
  }
  Future<void>delete(int id)async{
    final database = await DatabaseServices().database;
    print("id----------${id}");
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''',[id]);
  }
}
