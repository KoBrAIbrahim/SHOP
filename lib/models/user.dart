import 'package:flutter/material.dart';

class UserIdProvider extends ChangeNotifier {
  int _userId = 1; 

  int get userId => _userId; 

  void setUserId(int id) {
    _userId = id;
    notifyListeners(); 
  }
}
