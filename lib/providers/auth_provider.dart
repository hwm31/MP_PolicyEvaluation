// providers/auth_provider.dart
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userId = '';
  bool _isMP = false; // 국회의원(정책담당자) 여부

  bool get isLoggedIn => _isLoggedIn;
  String get userId => _userId;
  bool get isMP => _isMP;

  void login(String userId, bool isMP) {
    _isLoggedIn = true;
    _userId = userId;
    _isMP = isMP;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userId = '';
    _isMP = false;
    notifyListeners();
  }
}