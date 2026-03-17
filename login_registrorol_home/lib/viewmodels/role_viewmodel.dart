import 'package:flutter/material.dart';
import '../services/role_service.dart';
import '../models/role.dart';
import '../models/create_role_response.dart';

class RoleViewModel extends ChangeNotifier {
  final RoleService _roleService = RoleService();
  
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  CreateRoleResponse? _lastResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  CreateRoleResponse? get lastResponse => _lastResponse;

  Future<bool> createRole(String name, String description) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final role = Role(
        name: name.trim(),
        description: description.trim(),
      );
      
      final response = await _roleService.createRole(role);
      _lastResponse = response;
      
      _isLoading = false;
      _successMessage = '¡Rol creado exitosamente!';
      notifyListeners();
      return true;
      
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _roleService.dispose();
    super.dispose();
  }
}