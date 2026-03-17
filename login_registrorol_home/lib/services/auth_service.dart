import 'dart:convert';
import '../models/login_request.dart';
import '../models/login_response.dart';
import 'api_service.dart';
import '../utils/constants.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiService.post(
        ApiConstants.loginEndpoint,
        request.toJson(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return LoginResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error en el login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al intentar iniciar sesión: $e');
    }
  }

  void dispose() {
    _apiService.dispose();
  }
}