import 'package:flutter/material.dart';

//全局变化跳转持久化
class CurrentIndexProvide with ChangeNotifier{

  int currentIndex = 0;
  gotoWhere(int newIndex){
    currentIndex = newIndex;
    notifyListeners();
  }

}