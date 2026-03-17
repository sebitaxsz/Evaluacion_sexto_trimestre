import 'dart:convert';
import '../models/role.dart';
import '../models/create_role_response.dart';
import 'api_service.dart';

class RoleService {
  final ApiService _apiService = ApiService();

  Future<CreateRoleResponse> createRole(Role role) async {
    try {
      final response = await _apiService.post(
        '/api_v1/role',
        role.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return CreateRoleResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error al crear el rol: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  void dispose() {
    _apiService.dispose();
  }
}