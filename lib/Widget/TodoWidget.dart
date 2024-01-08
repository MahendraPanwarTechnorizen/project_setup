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
  setData(context)async{
    Provider.of<MyProvider>(context,listen: true).controller.text=widget.todo!.title!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.todo!=null)
    setData(context);
  }
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo!=null;
    return Consumer<MyProvider>(
      builder: (context,value,child) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Todo ':"Add Todo"),
          content: TextFormField(
            autofocus: true,
            controller: value.controller,
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("cancel")),
            TextButton(onPressed: (){
              widget.onSubmit(value.controller.text);

            }, child: Text("ok")),
          ],
        );
      }
    );
  }
}
