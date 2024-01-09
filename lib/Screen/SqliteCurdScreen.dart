import 'package:intl/intl.dart';
import 'package:project_setup/Model/todoList.dart';
import 'package:project_setup/Screen/auth/LoginScreen.dart';
import 'package:project_setup/Utils/GlobalKeys.dart';
import 'package:project_setup/Utils/ImportFile.dart';
import 'package:project_setup/Utils/createRoute.dart';
import 'package:project_setup/Widget/TodoWidget.dart';

class CurdOperation extends StatefulWidget {
  const CurdOperation({super.key});

  @override
  State<CurdOperation> createState() => _CurdOperationState();
}

class _CurdOperationState extends State<CurdOperation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MyProvider>(context, listen: false).fetchTodos;
    print("objectttttt");

    return Scaffold(
      appBar: AppBar(
        title: Text("Curd Operation"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, createRoute(LoginScreen()));
          }, icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: Consumer<MyProvider>(builder: (context, value, child) {
        return FutureBuilder<List<TodoList>>(
          future: futureTodos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final todos = snapshot.data;
              return todos == null
                  ? const Center(
                      child: Text("No todos"),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final todo = todos![index];
                        // final subtitle = DateFormat('dd MMM yyyy').format(DateTime.parse(todo.updatedAt??todo.createdAt));
                        return ListTile(
                          onTap: () {
                            value.controller.text = todo!.title!;
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return CreateTodoWidget(
                                      todo: todo,
                                      onSubmit: (title) {
                                        print("titlr------$title");
                                        value.submitOnUpdate(
                                            title, context, todo.id ?? 0);
                                      });
                                });
                          },
                          // leading: Image.network(),
                          title: Text(todo.title ?? 'k'),
                          subtitle: Text("subtitle"),
                          trailing: IconButton(
                              onPressed: () async {
                                value.delete(todo.id, context);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                      itemCount: todos != null ? todos.length : 0);
            }
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return Consumer<MyProvider>(builder: (context, value, child) {
                  return CreateTodoWidget(onSubmit: (title) async {
                    value.submitOnCreate(title, context);
                  });
                });
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
