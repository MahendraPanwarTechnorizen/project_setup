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
getData(context)async{
  await Provider.of<MyProvider>(context,listen: false).fetchTodos;
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Curd Operation"),),
      body: Consumer<MyProvider>(
        builder: (context,value,child) {
          return FutureBuilder<List<TodoList>>(
            future: value.futureTodos,
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
                           onSubmit:(title){
                           value.submit(title, context, todo.id??0);
                           }
                       );
                     });
                   },
                   title: Text(todo.title ?? 'k'),
                   subtitle: Text("subtitle"),
                   trailing: IconButton(onPressed: () async {
                  value.delete(todo.id, context);
                   },icon: Icon(Icons.delete,color: Colors.red,)),
                 );
               }, separatorBuilder: (context,index)=>const SizedBox(height: 12,), itemCount: todos!=null?todos.length:0);
             }
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_){
            return Consumer<MyProvider>(
              builder: (context,value,child) {
                return CreateTodoWidget(
                  onSubmit:(title)async{
                   int i = await value.todoDB.create(title: title.toString(),);
                   print("i--------$i");
                    print(mounted);
                   value.fetchTodos();
                    Navigator.of(context).pop();
                    if (!mounted) return;

                  }
                );
              }
            );
          });
        },
        child: Icon(Icons.add),

      ),
    );
  }
}
