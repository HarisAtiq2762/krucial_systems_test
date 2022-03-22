import 'package:flutter/material.dart';
class HomeScrollAnimation extends ChangeNotifier{
  double height = 0.4;
  void changeHeight(){
    if(height==0.4){
      height = 1.0;
    }else{
      height = 0.4;
    }
    notifyListeners();
  }
}