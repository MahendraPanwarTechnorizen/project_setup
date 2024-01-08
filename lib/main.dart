import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_setup/Screen/SqliteCurdScreen.dart';
import 'package:project_setup/Utils/AppColors.dart';
import 'package:project_setup/Utils/BottomNavigationBar.dart';
import 'package:project_setup/Utils/SDP.dart';
import 'package:provider/provider.dart';

import 'Providers/Common.dart';

void main() {
  
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyProvider()),
    ],
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SDP.init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
          color: AppColors.primary,
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 18)
      ),
        textTheme:  TextTheme(
          displayLarge: TextStyle(fontSize:SDP.sdp(32), fontWeight:
          FontWeight.bold,color: Colors.white),
          bodyLarge: TextStyle(fontSize:SDP.sdp(16), color: Colors.black87),
          labelLarge: TextStyle(fontSize: SDP.sdp(18), fontWeight: FontWeight.bold, color: Colors.white),
        ),
        buttonBarTheme: ButtonBarThemeData(buttonHeight: SDP.sdp(40),),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton
            .styleFrom(backgroundColor: AppColors.primary,
          textStyle: TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0), // Set the border radius here
        ),)),
         snackBarTheme: SnackBarThemeData(shape: RoundedRectangleBorder
         (borderRadius: BorderRadius.circular(0.0),), backgroundColor: AppColors.primary),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor:Colors.white,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData
          (backgroundColor: Colors.white),
        // Other configurations for your app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: const CurdOperation(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   // void _incrementCounter() {
//   //   setState(() {
//   //     _counter++;
//   //     const snackBar = SnackBar(
//   //       content: Text('Yay! A SnackBar!'),
//   //      /// If you want change bg color
//   //       /// backgroundColor: Colors.red,
//   //     );
//   //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '${Provider.of<MyProvider>(context,listen: true).mycount}',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             ElevatedButton(
//
//               onPressed: (){
//                 showModalBottomSheet(context: context, builder:  (context){
//                   return
//                   Container(
//                     height: 150,
//                     width: MediaQuery.of(context).size.width,
//
//                   );});
//               }, child: Text("Button",style: Theme
//                   .of(context).textTheme.displayLarge?.copyWith(fontSize: 16,)
//               ,),)
//           ],
//         ),
//       ),
//       floatingActionButton: Consumer<MyProvider>(
//         builder: (context,controller,child) {
//           return FloatingActionButton(
//             onPressed: controller.increment(),
//             tooltip: 'Increment',
//             child: const Icon(Icons.add),
//           );
//         }
//       ),
//
//     // This trailing comma makes
//     // auto-formatting
//       // nicer for build methods.
//     );
//   }
// }
