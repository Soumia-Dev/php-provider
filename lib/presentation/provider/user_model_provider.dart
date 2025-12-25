import 'package:flutter/cupertino.dart';

class UserModelProvider extends ChangeNotifier {
  Map<String, dynamic> _currentUser = {};
  void onUpdateUser(Map<String, dynamic> user) {
    _currentUser = user;
    notifyListeners();
  }

  Map<String, dynamic> get currentUser => _currentUser;
}
