import 'package:flutter/material.dart';
import 'package:grtabstore/services/adminService.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _adminEmail;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get adminEmail => _adminEmail;

  final AdminService _adminService = AdminService();

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _adminService.login(email, password);
      if (success) {
        _isAuthenticated = true;
        _adminEmail = email;
      }
      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _isLoading = false;
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _adminService.logout();
    _isAuthenticated = false;
    _adminEmail = null;
    notifyListeners();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final isAuth = await _adminService.checkAuth();
      _isAuthenticated = isAuth;
      if (!isAuth) {
        _adminEmail = null;
      }
      notifyListeners();
    } catch (e) {
      _isAuthenticated = false;
      _adminEmail = null;
      notifyListeners();
    }
  }

  Future<void> initializeAuth() async {
    await _checkAuthStatus();
  }
}
