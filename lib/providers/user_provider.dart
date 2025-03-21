import 'package:evnt_planning_app/model/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
