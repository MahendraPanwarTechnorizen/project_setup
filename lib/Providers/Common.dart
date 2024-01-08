




import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  int mycount = 0;

  int get count => mycount;

   increment() {
    mycount++;
    notifyListeners();
  }
}