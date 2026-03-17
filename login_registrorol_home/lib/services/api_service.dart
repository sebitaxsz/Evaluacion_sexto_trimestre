import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  final http.Client _client = http.Client();

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    
    try {
      final response = await _client.post(
        url,
        headers: ApiConstants.headers,
        body: json.encode(body),
      );
      
      return response;
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}