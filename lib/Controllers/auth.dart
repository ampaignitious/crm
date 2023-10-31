import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
    bool _isAuthenticated = false;
 
    bool get isAuthenticated => _isAuthenticated;
 
    Future<bool> login(String email, String password) async {
        _isAuthenticated = true;
        notifyListeners();
        return true;
    }
}