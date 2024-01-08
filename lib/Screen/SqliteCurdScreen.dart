import 'package:intl/intl.dart';
import 'package:project_setup/Model/todoList.dart';
import 'package:project_setup/Utils/ImportFile.dart';
import 'package:project_setup/Widget/TodoWidget.dart';

class CurdOperation extends StatefulWidget {
  const CurdOperation({super.key});

  @override
  State<CurdOperation> createState() => _CurdOperationState();
}

class _CurdOperationState extends State<CurdOperation> {
  Future<List<TodoList>>?futureTodos;
  final todoDB=TodoDB();
  void fetchTodos(){
    setState(() {
      futureTodos=todoDB.fetchAll();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Curd Operation"),),
      body: FutureBuilder<List<TodoList>>(
        future: futureTodos,
        builder: (context,snapshot){
         if(snapshot.connectionState == ConnectionState.waiting){
           return const Center(child: CircularProgressIndicator(),);
         }
         else{
           final todos= snapshot.data;
           // print("todos------todos------${todos!.length}") ;
           return todos==null?const Center(
             child: Text("No todos"),
           ):ListView.separated(itemBuilder: (context,index){
             final todo=todos![index];
             // final subtitle = DateFormat('dd MMM yyyy').format(DateTime.parse(todo.updatedAt??todo.createdAt));
             return ListTile(
               onTap: (){
                 showDialog(context: context, builder: (_){
                   return CreateTodoWidget(
                     todo: todo,
                       onSubmit:(title)async{
                         await todoDB.update(id:todo.id??0,title: title
                             .toString());
                         if (!mounted) return;
                         fetchTodos();
                         Navigator.of(context).pop();
                       }
                   );
                 });
               },
               title: Text(todo.title ?? 'k'),
               subtitle: Text("subtitle"),
               trailing: IconButton(onPressed: () async {
                 await todoDB.delete(todo.id??0);
                 fetchTodos();
               },icon: Icon(Icons.delete,color: Colors.red,)),
             );
           }, separatorBuilder: (context,index)=>const SizedBox(height: 12,), itemCount: todos!=null?todos.length:0);
         }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_){
            return CreateTodoWidget(
              onSubmit:(title)async{
               int i = await todoDB.create(title: title.toString(),);
               print("i--------$i");
                print(mounted);
                fetchTodos();
                Navigator.of(context).pop();
                if (!mounted) return;

              }
            );
          });
        },
        child: Icon(Icons.add),

      ),
    );
  }
}
