import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  //  --- Estados --- //
  bool _isLoading = false;
  String? _errorMessage;
  LoginResponse? _loginResponse;
  // ---------------- //


  //  --- GEtters --- //
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginResponse? get loginResponse => _loginResponse;
  // --------------- //


  // --- MEtodo de logueo --- //
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = LoginRequest(
        apiUser: email,
        apiPassword: password,
      );

      final response = await _authService.login(request);
      _loginResponse = response;
      _isLoading = false;
      notifyListeners();
      return true;
      
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
  // -------------------------------------------------------------- //

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }
}