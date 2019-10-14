import 'package:flutter/material.dart';

class Counter with ChangeNotifier{

  int value = 0;

  inCrement(){
    value++;
    notifyListeners();
  }

}