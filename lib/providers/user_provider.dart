import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import '../data_models/user.dart';

class UserProvider with ChangeNotifier {
  OurUser? _user;
  final AuthMethods _authMethods = AuthMethods();

  OurUser get getUser => _user!;

  Future<void> refreshUser() async {
    OurUser user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
