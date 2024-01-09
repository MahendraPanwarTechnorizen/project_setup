import 'package:flutter/material.dart';
import 'package:project_setup/Providers/Common.dart';
import 'package:project_setup/Screen/SqliteCurdScreen.dart';
import 'package:project_setup/Screen/auth/LoginScreen.dart';
import 'package:project_setup/Utils/GlobalKeys.dart';
import 'package:project_setup/Utils/createRoute.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(seconds: 3), () {
    Navigator.pushReplacement(context, createRoute(LoginScreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   Provider.of<MyProvider>(context, listen: false).fetchTodos;
    return Scaffold(
      body: Center(child: Icon(Icons.flutter_dash,size: 50,color: Colors.blue,)),
    );
  }
}
