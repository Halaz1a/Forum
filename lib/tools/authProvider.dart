import 'package:flutter/material.dart';
import 'secureStorage.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void admin() async {
    _isAdmin = await SecureStorage().readAdmin();
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _isAdmin = false;
    notifyListeners();
  }
}
