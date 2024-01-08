import 'package:project_setup/Model/todoList.dart';

import '../Utils/ImportFile.dart';

class CreateTodoWidget extends StatefulWidget {
  final TodoList? todo;
  final ValueChanged onSubmit;
  const CreateTodoWidget({super.key, this.todo, required this.onSubmit});

  @override
  State<CreateTodoWidget> createState() => _CreateTodoWidgetState();
}

class _CreateTodoWidgetState extends State<CreateTodoWidget> {
  TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo!=null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit Todo ':"Add Todo"),
      content: TextFormField(
        autofocus: true,
        controller: controller,
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("cancel")),
        TextButton(onPressed: (){
          widget.onSubmit(controller.text);

        }, child: Text("ok")),
      ],
    );
  }
}
