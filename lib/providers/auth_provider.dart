import 'package:flutter/material.dart';
import 'package:task_app/model/my_user.dart';

class AuthProviders extends ChangeNotifier{
  MyUser? currentUser;
  void changeUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }
}