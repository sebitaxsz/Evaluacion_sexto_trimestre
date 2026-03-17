// Clase api constante
// toma una variable statica la cual sera el http
// Despues se tomara otra variable statica y constante para consumir el endpoint deseado

class ApiConstants {
  static const String baseUrl = 'http://localhost:3000';
  static const String loginEndpoint = '/api_v1/apiUserLogin';
  
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}