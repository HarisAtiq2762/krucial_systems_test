import 'package:flutter/cupertino.dart';

class Store extends ChangeNotifier{
  String name;
  String category;
  String address;
  String rating;
  String img;

  Store({this.name,this.category,this.address,this.img,this.rating});
}